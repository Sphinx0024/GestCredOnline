using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Diagnostics;
using System.Linq;
using System.ServiceProcess;
using System.Text;
using System.Threading.Tasks;
using System;
using System.ServiceProcess;
using System.Timers;
 


namespace GestCredOnline.NotificationsService
{
    using Helpers;
    using System.Runtime.Remoting.Messaging;

    public partial class SrvNotifications : ServiceBase
    {
        private Timer srvTimerMinute = new Timer();
        private EventLogger evLog = EventLogger.Instance;

        public SrvNotifications()
        {
            InitializeComponent();
        }

        protected override void OnStart(string[] args)
        {
            evLog.WriteLog("Service en démarrage ...", true);
            try
            {
                srvTimerMinute.Elapsed += new ElapsedEventHandler(OnElapsedSeconde);
                srvTimerMinute.Interval = Utilities.ConvertMinuteInMillisecond(Mapping.srv_interval);
                evLog.WriteLog(string.Format("Execution chaque {0} minutes", Mapping.srv_interval), true);
                srvTimerMinute.Enabled = true;
            }
            catch (Exception e)
            {
                evLog.WriteLog(e.ToString(), true);
            }
        }

        protected override void OnStop()
        {
            evLog.WriteLog("Service est arreté ...", true);
        }



        private async void OnElapsedSeconde(object source, ElapsedEventArgs e)
        {
            try
            {
                await Helpers.Notification.Process();
            }
            catch (Exception ex)
            { 
                evLog.WriteLog(ex.ToString(), true);
            }
           
        }
    }
}
