// このファイルは、Firebase Functionsのエントリーポイントです。
const logger = require("firebase-functions/logger"); // TODO: logが不要になったら削除
const functions = require('firebase-functions');
const {defineSecret} = require('firebase-functions/params');
// stripeの秘密鍵を取得
const stripeSecretKey = defineSecret('STRIPE_SECRET_KEY');
// firestoreの初期化
const admin = require('firebase-admin');
admin.initializeApp();
const db = admin.firestore();

exports.createPaymentIntent = functions.runWith({
        secrets: ["STRIPE_SECRET_KEY"],
    }).https.onCall(async (data, context) => {
    try{
        // 認証されていない場合はエラーを返す
        if (!context.auth) {
            throw new functions.https.HttpsError('unauthenticated', 'The function must be called while authenticated.');
        }

        // stripeモジュールを初期化
        const stripe = require('stripe')(stripeSecretKey.value());

        let customerId;
        if (context.auth.uid) {
            // FirestoreからStripeの顧客IDを読み込む
            const userRef = db.collection('users').doc(context.auth.uid);
            const userDoc = await userRef.get();
        
            if (userDoc.exists && userDoc.data().stripeCustomerId) {
                customerId = userDoc.data().stripeCustomerId;
            } else {
                // Stripeで新規顧客を作成
                const newCustomer = await stripe.customers.create();
                customerId = newCustomer.id;
                
                // FirestoreにStripeの顧客IDを保存
                await userRef.set({ stripeCustomerId: customerId }, { merge: true });
                
                logger.log("顧客ID: " + customerId + "を作成しました。");
            }
        }

        // Ephemeral Keyを作成
        const ephemeralKey = await stripe.ephemeralKeys.create(
            { customer: customerId },
            { apiVersion: '2022-11-15' }
        );
        // PaymentIntent の作成
        const paymentIntent = await stripe.paymentIntents.create({
            amount: 700,
            currency: `jpy`,
            customer: customerId,
            automatic_payment_methods: {
            enabled: true,
            },
        });
    
        // アプリ側で必要な値を返却
        return {
            paymentIntent: paymentIntent.client_secret,
            ephemeralKey: ephemeralKey.secret,
            customer: customerId,
        };
    } catch (error) {
        console.error(`error: %j`, error);
        return {
            title: `エラーが発生しました`,
            message: error,
        };
    }
});

