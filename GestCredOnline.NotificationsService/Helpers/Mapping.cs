using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GestCredOnline.NotificationsService.Helpers
{

    public class Mapping
    {
        public static int srv_interval = int.Parse(ConfigurationManager.AppSettings["srv_interval"] != null ? ConfigurationManager.AppSettings["srv_interval"].ToString().Trim() : "0");
       
        public static Helpers.MailConfig MailConfig = new MailConfig()
        {
            gLogin = (ConfigurationManager.AppSettings["g_Login"] != null ? ConfigurationManager.AppSettings["g_Login"].ToString() : ""),
            gsmtp = (ConfigurationManager.AppSettings["g_smtp"] != null ? ConfigurationManager.AppSettings["g_smtp"].ToString() : ""),
            gport = short.Parse(ConfigurationManager.AppSettings["g_port"] != null ? ConfigurationManager.AppSettings["g_port"].ToString() : ""),
            gPwd = (ConfigurationManager.AppSettings["g_Pwd"] != null ? ConfigurationManager.AppSettings["g_Pwd"].ToString() : ""),
            gssl = bool.Parse(ConfigurationManager.AppSettings["g_ssl"] != null ? ConfigurationManager.AppSettings["g_ssl"].ToString() : "0")
        };
         
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

        public enum Status : byte
        {
            Nouveau = 0,
            EnCours = 1,
            Annuler = 2,
            Valider = 3,
            Rejeter = 4,
            Closed = 5,
            Arbitrage = 7,
            Archiver = 8,
            EnAttente = 9,
            Engager = 10 
        }
          
    }

}
