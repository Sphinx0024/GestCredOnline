using System;
using System.Collections.Generic;
using Newtonsoft.Json;


namespace GestCredOnline.NotificationsService.Helpers
{
    public static class Utilities
    {
        public static int ConvertMinuteInMillisecond(int _Minute)
        {
            return _Minute * 60000;
        }

        public static DateTime ConvertStringToDate(string Date)
        {
            IFormatProvider culture = new System.Globalization.CultureInfo("fr-FR", true);
            return DateTime.Parse(Date, culture, System.Globalization.DateTimeStyles.AssumeLocal);
        }

        public static string TraiteListeString(string strAtraiter, string[] separateur)
        {
            string str = "";
            try
            {
                if (strAtraiter.Trim() != "")
                {
                    var T = TraiteStringToListe(strAtraiter, separateur);   //strAtraiter.Split(separateur, StringSplitOptions.RemoveEmptyEntries);
                    if (T != null)
                    {
                        if (T.Length > 0)
                        {
                            foreach (string s in T)
                            {
                                if (s.Trim() != "")
                                {
                                    str += s.Trim() + "#;";
                                }
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                str = ex.ToString();
            }
            return str;
        }

        public static string[] TraiteStringToListe(string strAtraiter, string[] separateur)
        {
            try
            {
                if (strAtraiter.Trim() != "")
                {
                    return strAtraiter.Replace(" ", "").Split(separateur, StringSplitOptions.RemoveEmptyEntries);
                }
                else return null;
            }
            catch (Exception)
            {
                return null;
            }

        }

        public static bool IsDictionary(object o)
        {
            try
            {
                if (o == null) return false;
                return o is System.Collections.IDictionary &&
                       o.GetType().IsGenericType &&
                       o.GetType().GetGenericTypeDefinition().IsAssignableFrom(typeof(Dictionary<,>));
            }
            catch
            {
                return false;
            }
        }

        public static bool IsList(object o)
        {
            try
            {
                if (o == null) return false;
                return o is System.Collections.IList &&
                       o.GetType().IsGenericType &&
                       o.GetType().GetGenericTypeDefinition().IsAssignableFrom(typeof(List<>));
            }
            catch
            {
                return false;
            }
        }
         
        public static string generateRandomString(int _size)
        {
            Random rand = new Random();
            int stringlen = rand.Next(4, _size);
            int randValue;
            string str = "";
            char letter;
            for (int i = 0; i < stringlen; i++)
            {
                randValue = rand.Next(0, 26);
                letter = Convert.ToChar(randValue + 65);
                str = str + letter;
            }
            return str;

        }


    }
}
