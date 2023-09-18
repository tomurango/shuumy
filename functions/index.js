/**
 * Import function triggers from their respective submodules:
 *
 * const {onCall} = require("firebase-functions/v2/https");
 * const {onDocumentWritten} = require("firebase-functions/v2/firestore");
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

/*
const {onRequest} = require("firebase-functions/v2/https");
const logger = require("firebase-functions/logger");
*/

const functions = require('firebase-functions');
const {defineSecret} = require('firebase-functions/params');
// stripeの秘密鍵を取得
const stripeSecretKey = defineSecret('STRIPE_SECRET_KEY');
//const stripeSecretKey = functions.config().stripe.secret_key;
// stripeモジュールを初期化
//const stripe = require('stripe')(stripeSecretKey.value());
const stripe = require('stripe')(stripeSecretKey);

//exports.createPaymentIntent = functions.https.onRequest(async (req, res) => {
exports.createPaymentIntent = functions.https.onCall(async (data, context) => {
    try{
        // 認証されていない場合はエラーを返す
        if (!context.auth) {
            throw new functions.https.HttpsError('unauthenticated', 'The function must be called while authenticated.');
        }

        // 既存の顧客IDを取得（なければ新規作成）
        const customerId = context.auth.uid || await stripe.customers.create().then(customer => customer.id);
        // Ephemeral Key (一時的なアクセス権を付与するキー)を作成
        const ephemeralKey = await stripe.ephemeralKeys.create(
            { customer: customerId },
            { apiVersion: `2022-11-15` }
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

/*
import {defineSecret} from "firebase-functions/params";
const apiKey = defineSecret('API_KEY');
const key = apiKey.value();

import * as functions from "firebase-functions";
*/

//const stripe = require("stripe")(process.env.STRIPE_SECRET_KEY);

/// PaymentIntent の作成
/*
export const createPaymentIntentTest = functions.https.onCall(async (_, context) => {
    try {
      // 既存の顧客IDを取得（なければ新規作成）
      const customerId = context.auth.uid || await stripe.customers.create().then(customer => customer.id);
  
      // Ephemeral Key (一時的なアクセス権を付与するキー)を作成
      // TODO:内容の確認と修正
      const ephemeralKey = await stripe.ephemeralKeys.create(
        { customer: customerId },
        { apiVersion: `2020-08-27` }
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
  */
