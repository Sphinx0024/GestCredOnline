using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GestCredOnline.NotificationsService.Helpers
{
    public class MailConfig
    {
        public string gLogin { get; set; }
        public string gsmtp { get; set; }
        public Int16 gport { get; set; }
        public string gPwd { get; set; }
        public bool gssl { get; set; }
    }

}
