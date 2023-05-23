using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Configuration;

namespace GestCredOnline.WebAPI.Helpers
{
    public static  class h_config
    {
        public static string  ConnexionOrionString = (ConfigurationManager.AppSettings["ConnStringORION"] != null ? ConfigurationManager.AppSettings["ConnStringORION"].ToString() : "");
        public static string ConnexionGestCredString = (ConfigurationManager.AppSettings["ConnStringGestCred"] != null ? ConfigurationManager.AppSettings["ConnStringGestCred"].ToString() : "");
         
        public static string  V_Client = (ConfigurationManager.AppSettings["VueCompte"] != null ? ConfigurationManager.AppSettings["VueCompte"].ToString() : "");
        
        public static string CORS_Allow = h_utilitaires.TraiteListeString(ConfigurationManager.AppSettings["Url_Autorise"].ToString(), new string[] { ";", "," }).Trim().Replace("#;", ",");

        public static int AuthDuration = 60;

        public static bool IsOrionDataBase = false;
         
        public static Helpers.SmsApiConfig SmsConfig = new SmsApiConfig()
        {
            smsLogin = (ConfigurationManager.AppSettings["sms_login"] != null ? ConfigurationManager.AppSettings["sms_login"].ToString() : ""),
            smsPassword = (ConfigurationManager.AppSettings["sms_password"] != null ? ConfigurationManager.AppSettings["sms_password"].ToString() : ""),
            smsSenderName = (ConfigurationManager.AppSettings["sms_sender_name"] != null ? ConfigurationManager.AppSettings["sms_sender_name"].ToString() : ""),
            smsApiUrl = (ConfigurationManager.AppSettings["sms_api_url"] != null ? ConfigurationManager.AppSettings["sms_api_url"].ToString() : ""),
            smsApiLoginUrl = (ConfigurationManager.AppSettings["sms_api_login_url"] != null ? ConfigurationManager.AppSettings["sms_api_login_url"].ToString() : ""),
            smsApiSendUrl = (ConfigurationManager.AppSettings["sms_api_send_url"] != null ? ConfigurationManager.AppSettings["sms_api_send_url"].ToString() : ""),
            smsApiAppsKey = (ConfigurationManager.AppSettings["sms_api_apps_key"] != null ? ConfigurationManager.AppSettings["sms_api_apps_key"].ToString() : ""),
            smsApiSender = (ConfigurationManager.AppSettings["sms_api_sender"] != null ? ConfigurationManager.AppSettings["sms_api_sender"].ToString() : ""),
            smsTemplate = (ConfigurationManager.AppSettings["sms_template"] != null ? ConfigurationManager.AppSettings["sms_template"].ToString() : ""),

        };


    }
}