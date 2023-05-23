using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GestCredOnline.WebAPI.Helpers
{
    public class SmsApiConfig
    {
        public string smsLogin { get; set; }
        public string smsPassword { get; set; }
        public string smsSenderName { get; set; }
        public string smsApiUrl { get; set; }
        public string smsApiLoginUrl { get; set; }
        public string smsApiSendUrl { get; set; }
        public string smsApiAppsKey { get; set; }
        public string smsApiSender { get; set; }
        public string smsTemplate { get; set; }


    }
}