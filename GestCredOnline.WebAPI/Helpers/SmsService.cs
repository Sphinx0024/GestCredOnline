using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http.Headers;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;
using System.Web;
using System.Net;

namespace GestCredOnline.WebAPI.Helpers
{
    public class SmsService
    {
        private static SmsApiConfig _config;
        public static string oToken = "";
        public static string oAccesType = "";
        public static EventLogger Log = Helpers.EventLogger.Instance;

        public SmsService(SmsApiConfig smsApiConfig)
        {
            _config = smsApiConfig;
        }

        public async Task<bool> SendSms(string Message, string Numero)
        {
            string msg = "";
            if (!Numero.StartsWith("+225"))
            {
                Numero = "+225" + Numero;
            }
            EventLogger.Instance.WriteLog(Numero);
            await ApiConnexion(_config.smsApiUrl, _config.smsApiLoginUrl, _config.smsLogin, _config.smsPassword);
            msg = "{\"outboundSMSMessageRequest\": {\"address\": \"tel:" + Numero + "\",\"outboundSMSTextMessage\": {\"message\": \"" + Message + "\"},\"senderAddress\": \"tel:" + _config.smsApiSender + "\",\"senderName\": \"" + _config.smsSenderName + "\"}}";

            string ActionSmsUrl = string.Format(_config.smsApiSendUrl, _config.smsApiSender);
            return await ApiPost(_config.smsApiUrl, ActionSmsUrl, msg);
        }

        private async static Task<bool> ApiConnexion(string _Url, string LoginAction, string Login, string Password)
        {
            string strurl = _Url;
            Uri url = new Uri(strurl);
            LoginInfo login = new LoginInfo();
            bool IsConnected = false;
            login.Login = Login;
            login.Password = Password;
            try
            {
                Log.WriteLog("Connexion", true);

                using (HttpClient client = new HttpClient())
                {
                    System.Net.ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls12;
                    Log.WriteLog("Entete de requete", true);
                    client.BaseAddress = url;
                    client.DefaultRequestHeaders.Accept.Clear();
                    client.DefaultRequestHeaders.TryAddWithoutValidation("Authorization", _config.smsApiAppsKey);
                    client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue(_config.smsApiAppsKey.Split(' ')[0].Trim(), _config.smsApiAppsKey.Split(' ')[1].Trim());
                    client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                     
                    string QueryBody = string.Format("grant_type={0}", "client_credentials");
                    byte[] HttpContentbyteArray = Encoding.ASCII.GetBytes(QueryBody);
                    HttpContent content = new ByteArrayContent(HttpContentbyteArray);
                    content.Headers.ContentType = new System.Net.Http.Headers.MediaTypeHeaderValue("application/x-www-form-urlencoded");

                    HttpResponseMessage response = await client.PostAsync(LoginAction, content);
                    Log.WriteLog("Reponse de requete", true);
                    var resultJSON = await response.Content.ReadAsStringAsync();
                    Log.WriteLog(resultJSON.ToString(), true);
                    var result = JsonConvert.DeserializeObject<UserInfos>(resultJSON);
                    Log.WriteLog("Traitement de la reponse", true);
                    if (result != null)
                    {
                        Log.WriteLog(result.access_token, true);
                        SmsService.oAccesType = result.token_type;
                        SmsService.oToken = result.access_token;
                        IsConnected = true;
                    }
                };

            }
            catch (System.Net.Http.HttpRequestException ex)
            {
                Log.WriteLog(ex.ToString(), true);
            }
            return IsConnected;
        }

        private async static Task<bool> ApiGet(string _UrlBaseAdresse, string UrlAction)
        {
            bool isOk = false;
            try
            {
                Log.WriteLog("Envoi", true);
                Log.WriteLog(UrlAction, true);
                Log.WriteLog(SmsService.oToken, true);

                var client = new HttpClient();
                client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue(SmsService.oToken); //SmsService.oAccesType,
                client.BaseAddress = new Uri(_UrlBaseAdresse);
                string Url = UrlAction;


                var res = await client.GetAsync(Url);
                var resultJSON = await res.Content.ReadAsStringAsync();
                if (res.IsSuccessStatusCode) { isOk = true; }

            }
            catch (Exception ex)
            {
                Log.WriteLog(ex.ToString(), true);
            }
            return isOk;
        }

        private async static Task<bool> ApiPost(string _UrlBaseAdresse, string UrlAction, string sms)
        {

            bool isOk = false;

            try
            {
                Log.WriteLog("Envoi SMS", true);
                Log.WriteLog(sms, true);

                var client = new HttpClient();
                System.Net.ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls12;
                client.BaseAddress = new Uri(_UrlBaseAdresse);
                client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue(SmsService.oAccesType, SmsService.oToken);
                HttpContent c = new StringContent(sms, Encoding.UTF8, "application/json");
                var res = await client.PostAsync(UrlAction, c);
                var resultJSON = await res.Content.ReadAsStringAsync();
                Log.WriteLog(resultJSON, true);
                if (res.IsSuccessStatusCode)
                {
                    isOk = true;
                }
            }
            catch (Exception ex)
            {
                Log.WriteLog(ex.ToString(), true);
            }
            return isOk;
        }

        public class Sms
        {
            public string message { get; set; }
            public string numero { get; set; }
            public string senderName { get; set; }
        }

        private class LoginInfo
        {
            public string Login { get; set; }
            public string Password { get; set; }
        }

        private class UserInfos
        {
            public string token_type { get; set; }
            public string access_token { get; set; }
            public int expires_in { get; set; }

            //public string Login { get; set; }
            //public string Password { get; set; }
            //public string Token { get; set; }
            //public int StatusCode { get; set; }
            //public string ReasonPhrase { get; set; }
            // public bool isActive { get; set; }
            // public int TokenExpire { get; set; } 
            // public bool IsSucceeStatusCode { get; set; }
            // public string Nom { get; set; }
            // public string DateCreation { get; set; }
            // public string Profil { get; set; }
            // public string RequestMessage { get; set; }
            // public string Content { get; set; }
            //  public string Headers { get; set; }
            // ResMess responseMsg { get; set; }
        }

        private class ResMess
        {
            VersMess Version { get; set; }
        }

        private class VersMess
        {
            public int _Major { get; set; }
            public int _Minor { get; set; }
            public int _Build { get; set; }
            public int _Revision { get; set; }
        }






    }


}