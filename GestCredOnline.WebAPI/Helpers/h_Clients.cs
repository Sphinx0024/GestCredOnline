using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Threading.Tasks;
using System.Configuration;

namespace GestCredOnline.WebAPI.Helpers
{
    public static  class h_Clients
    {
        public static  DataRow GetClientByRacine (string Racine)
        {
            DataRow R = null;
            GestCredOnline.CoreCalcul.BNICustomersInfos bNICustomersInfos = new CoreCalcul.BNICustomersInfos(h_config.ConnexionOrionString, h_config.IsOrionDataBase);
            string Q = string.Format("Select * from {0} where CLIENT='{1}'", h_config.V_Client , Racine );
            DataTable D = bNICustomersInfos.GetCustomerData(Q);

            if(D != null)
            {
                if(D.Rows.Count > 0)
                {
                    R = D.Rows[0];
                }
            }
            return R;
        }
    
        public static DataRow GetClientOTP (string Racine)
        {
            DataRow R = null;
            GestCredOnline.CoreCalcul.BNICustomersInfos bNICustomersInfos = new CoreCalcul.BNICustomersInfos(h_config.ConnexionGestCredString, false);
            string Q = string.Format("Select * from {0} where Racine={1} and DateDemande='{2}'", "ClientOTP", Racine, DateTime.Now.ToString("dd/MM/yyyy"));
            DataTable D = bNICustomersInfos.GetCustomerData(Q);

            if (D != null)
            {
                if (D.Rows.Count > 0)
                {
                    R = D.Rows[0];
                }
            }
            return R;
        }

        public static bool PostClientOTP (string Racine , string OTP)
        {
            GestCredOnline.CoreCalcul.BNICustomersInfos bNICustomersInfos = new CoreCalcul.BNICustomersInfos(h_config.ConnexionGestCredString, false);
            string Q = string.Format("INSERT INTO {0} (Racine, OTP, DateDemande) VALUES ('{1}', '{2}' , '{3}')",
                "ClientOTP", Racine, OTP, DateTime.Now.ToString("dd/MM/yyyy"));
           return  bNICustomersInfos.PostCustomerData(Q);
        }

        public static DataRow GetClientConnexion(string Racine , string Pwd)
        {
            DataRow R = null;
            GestCredOnline.CoreCalcul.BNICustomersInfos bNICustomersInfos = new CoreCalcul.BNICustomersInfos(h_config.ConnexionGestCredString, false);
            string Q = string.Format("Select * from {0} join {1} on CLIENT = Racine where Racine={2} and OTP='{3}' and DateDemande='{4}'", 
                "ClientOTP", "W_COMPTE", Racine, Pwd, DateTime.Now.ToString("dd/MM/yyyy"));
            DataTable D = bNICustomersInfos.GetCustomerData(Q);

            if (D != null) 
            {
                if (D.Rows.Count > 0)
                { 
                        R = D.Rows[0];
                 }
            }
            return R;
        }

        public static DataRow GetClientFromORION(string Racine)
        {
            DataRow R = null;
            GestCredOnline.CoreCalcul.BNICustomersInfos bNICustomersInfos = new CoreCalcul.BNICustomersInfos(h_config.ConnexionOrionString, h_config.IsOrionDataBase);
            string Q = string.Format("Select * from {0} where CLIENT='{1}'", h_config.V_Client, Racine);
            DataTable D = bNICustomersInfos.GetCustomerData(Q);

            if (D != null)
            {
                if (D.Rows.Count > 0)
                {
                    R = D.Rows[0];
                }
            }
            return R;
        }

 

        public static List<Models.EtatRequest > GetEtatRequests (string Racine)
        {
            List<Models.EtatRequest> Lst = new List<Models.EtatRequest>();
            GestCredOnline.CoreCalcul.BNICustomersInfos bNICustomersInfos = new CoreCalcul.BNICustomersInfos(h_config.ConnexionGestCredString, false);
            string Q = string.Format("Select * from {0} where AccountRacine='{1}'", "V_EtatRequest", Racine);
            DataTable D = bNICustomersInfos.GetCustomerData(Q);

            if (D != null)
            {
                if (D.Rows.Count > 0)
                {
                    foreach(DataRow R in D.Rows)
                    {
                        Lst.Add(new Models.EtatRequest {
                            R_ID = R["R_ID"] != null ? long.Parse(R["R_ID"].ToString()) : 0,
                            RequestID = R["RequestID"] != null ? long.Parse(R["RequestID"].ToString()) : 0,
                            Total = R["Total"] != null ? long.Parse(R["Total"].ToString()) : 0,
                            DemandeEtat = R["DemandeEtat"] != null ? int.Parse(R["DemandeEtat"].ToString()) : 0,
                            Risque = R["Risque"] != null ? (R["Risque"].ToString()) : "",
                            CreditProgram = R["CreditProgram"] != null ? (R["CreditProgram"].ToString()) : "",
                            AccountRacine = R["AccountRacine"] != null ? (R["AccountRacine"].ToString()) : ""
                        }) ;
                    } 
                }
            }

            return Lst;

        }

        public async static Task<bool> SendSms(  string Message,  string Numero) { 
           return await SendSms("Share2021", "Share@@2021", Message, "BNI", Numero); 
        }



        public async static Task<bool> SendSms(  string Login , string Pwd , string Message , string Sender , string Numero)
        { 
            try
            {
                EventLogger.Instance.WriteLog("Config");
                EventLogger.Instance.WriteLog(h_config.SmsConfig.smsApiUrl);
                EventLogger.Instance.WriteLog(h_config.SmsConfig.smsSenderName);
                var msg = new Helpers.SmsService(h_config.SmsConfig); 
                await msg.SendSms(Message, Numero); 
            }
            catch (Exception ex)
            {  
               

                EventLogger.Instance.WriteLogToFile(ex.ToString()); 



            }
             
           
            return true;

        }

    }
}