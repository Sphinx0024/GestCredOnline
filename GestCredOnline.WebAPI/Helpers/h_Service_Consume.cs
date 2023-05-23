using Newtonsoft.Json;
using System;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Text;
using System.Threading.Tasks;

namespace GestCredOnline.WebAPI.Helpers
{
    public static class h_Service_Consume
    {
        public static string oToken = "";
        public static string oAccesType = ""; 
      //  public static EventLogger Log = Helpers.EventLogger.Instance;

        public async static Task<bool> ApiConnexion( string _Url, string LoginAction, string Login, string Password)
        {
            string strurl = _Url;
            Uri url = new Uri(strurl);
            LoginInfo login = new LoginInfo();
            bool IsConnected = false;
            login.Login = Login;
            login.Password = Password;
           // login.grant_type = "password"; 
            try
            { 
                var client = new HttpClient();
                client.BaseAddress = url; //grant_type=password&
                var response = await client.PostAsync(LoginAction, new StringContent(string.Format("Login={0}&Password={1}", login.Login, login.Password), Encoding.UTF8, "application/x-www-form-urlencoded"));
  
                var resultJSON = await response.Content.ReadAsStringAsync();
               // Log.WriteLog(resultJSON, true);
                var result = JsonConvert.DeserializeObject<UserInfos>(resultJSON);
                if (result != null)
                {
                    h_Service_Consume.oAccesType = "Bearer"; /*result.Token*/;
                    h_Service_Consume.oToken = result.Token;
                    IsConnected = true;
                }
            }
            catch (System.Net.Http.HttpRequestException ex)
            {
               // Log.WriteLog("Erreur", true);
               // Log.WriteLog(ex.ToString(), true);
                throw ex;
            }
            return IsConnected;
        }


        public async static Task<bool> ApiGet(string _UrlBaseAdresse, string UrlAction)
        {
            bool isOk = false;
            try
            {
                var client = new HttpClient();
                client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue( h_Service_Consume.oToken); //h_Service_Consume.oAccesType,
                client.BaseAddress = new Uri(_UrlBaseAdresse);
                string Url = UrlAction;
              //  Log.WriteLog(h_Service_Consume.oToken, true);
               // Log.WriteLog("SMS GET", true);
                var res = await client.GetAsync(Url);
                var resultJSON = await res.Content.ReadAsStringAsync();
              //  Log.WriteLog(resultJSON, true);
                if (res.IsSuccessStatusCode) { isOk = true; }
                 
            }
            catch (Exception ex)
            {
                throw ex;
               // Log.WriteLog(ex.ToString(), true);
               // isOk = false; 
            }
            return isOk;
        }


        public async static Task<bool> ApiPost(string _UrlBaseAdresse, string UrlAction, Sms sms)
        {
            
            bool isOk = false; 
            try
            {
                HttpContent c = new StringContent(JsonConvert.SerializeObject(sms, Formatting.None), Encoding.UTF8, "application/json");
                var client = new HttpClient();
                client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue(h_Service_Consume.oAccesType, h_Service_Consume.oToken);
                client.BaseAddress = new Uri(_UrlBaseAdresse);
                var res = await client.PostAsync(UrlAction, c);
               // Log.WriteLog("SMS", true);
                var resultJSON = await res.Content.ReadAsStringAsync();
               // Log.WriteLog(resultJSON, true);
                if (res.IsSuccessStatusCode)
                {
                    isOk = true;
                }
            }
            catch (Exception ex)
            {
               // Log.WriteLog("Erreur SMS", true);
               // Log.WriteLog(ex.ToString(), true);
                throw ex;
            } 
            return isOk;
        }
         
        public class Sms
        {
            public string message { get; set; }
            public string numero { get; set; }
            public string senderName { get; set; }
            // public string grant_type { get; set; }
        }

        private class LoginInfo
        {
            public string Login { get; set; }
            public string Password { get; set; }
           // public string grant_type { get; set; }
        }

        private class UserInfos
        {
            public string Login { get; set; } 
            public string Password { get; set; }
            public string Token { get; set; }   
            public int StatusCode { get; set; }
            public string ReasonPhrase { get; set; }
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