using System;
using System.Diagnostics;
using System.IO;
using System.Web.Services.Description;

namespace GestCredOnline.WebAPI.Helpers
{
    public sealed class EventLogger
    {
        private static EventLog eventLog = null;
        private static EventLogger instance = null;
        private static readonly object padlock = new object();

        public EventLogger()
        {
        }

        public static EventLogger Instance
        {
            get
            {
                lock (padlock)
                {
                    if (instance == null)
                    {
                        instance = new EventLogger();
                        eventLog = instance.InitLog();
                    }
                    return instance;
                }
            }
        }

        private EventLog InitLog()
        {
            eventLog = new EventLog();
            if (!System.Diagnostics.EventLog.SourceExists("AppClientSync"))
            {
                System.Diagnostics.EventLog.CreateEventSource("AppClientSync", "AppClientSync_Log");
            }
            eventLog.Source = "AppClientSync";
            eventLog.Log = "AppClientSync_Log";
            return eventLog;
        }

        public void WriteLog(string _Log, bool _WriteInFile = false)
        {
            WriteLogToFile(_Log);
            /* eventLog.WriteEntry(_Log);
             if (_WriteInFile == true) { 
            WriteLogToFile(_Log); 
            } */

            try
            {
                using (Models.GestCredOnline_DBEntities db = new Models.GestCredOnline_DBEntities())
                {
                    Models.Notification N = new Models.Notification();
                    N.Message = _Log;
                    N.Sender = "";
                    N.ToNumber = "";
                    db.Notification.Add(N);
                    db.SaveChanges();
                }
            }
            catch (Exception )
            {
                
            }
        }

        public void WriteLogToFile(string _Log)
        {
            _Log = DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss") + " :: " + _Log;
            string path = AppDomain.CurrentDomain.BaseDirectory + "\\Logs";

            if (!Directory.Exists(path))
            {
                Directory.CreateDirectory(path);
            }

            string filepath = AppDomain.CurrentDomain.BaseDirectory + "\\Logs\\AppClientSyncLog_" + DateTime.Now.Date.ToShortDateString().Replace('/', '_') + ".txt";

            if (!File.Exists(filepath))
            {
                using (StreamWriter sw = File.CreateText(filepath))
                {
                    sw.WriteLine(_Log);
                }
            }
            else
            {
                using (StreamWriter sw = File.AppendText(filepath)) { sw.WriteLine(_Log); }
            }

        }
    }
}