using System;
using System.Collections.Generic;
using System.Linq;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using GestCredOnline.NotificationsService.Models;
using System.Runtime.InteropServices;

namespace GestCredOnline.NotificationsService.Helpers
{
    public static  class Notification
    {
        public static async Task<bool> Process()
        {
           return await Send(GetWaitting());
        }

        public static List<Models.Notification> GetWaitting()
        {
            List<Models.Notification> notifications = new List<Models.Notification>();

            using(Models.BNI_Client_Apps_DBEntities db = new Models.BNI_Client_Apps_DBEntities())
            {
                notifications = db.Notification.Where(c=>c.Status== (byte) Mapping.Status.EnAttente).Take(50).ToList();
            } 
            return notifications;
        }
         
        public static async Task<bool> Send(List<Models.Notification> notifications)
        {
            bool send = false;
            Helpers.SmsService smsService = new Helpers.SmsService(Mapping.SmsConfig);
            if (notifications != null)
            {
                foreach (var notification in notifications)
                {
                    try
                    {
                        send = await smsService.SendSms(notification.Message, notification.ToNumber);
                   
                        if(send) { Close(notification.ID); }
                    }
                    catch (Exception ex)
                    {
                        EventLogger.Instance.WriteLog(ex.ToString(), true);
                    } 
                }
            }
            return send;
        }
            public static bool Close (long Id)
        {
            bool ok = false;

            using (Models.BNI_Client_Apps_DBEntities db = new Models.BNI_Client_Apps_DBEntities())
            {
               Models.Notification notification = db.Notification.Where(c => c.ID == Id).FirstOrDefault();
               if(notification != null) {
                    notification.Status = (byte)Mapping.Status.Closed;
                    db.SaveChanges();
                } 
            } 
            return ok;
        }


    }
}
