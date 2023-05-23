using System.Data;

namespace GestCredOnline.CoreCalcul
{
    public class BNICustomersInfos
    {
        private string _connexionString { set; get; }
        private bool _isOracleData { set; get; }

        public BNICustomersInfos(string connexionString, bool isOracleData)
        {
            this._connexionString = connexionString;
            this._isOracleData = isOracleData;
        }

        public DataTable GetCustomerData(string Query)
        {
            return BNIData.Commander.GetData(this._connexionString, this._isOracleData, Query);
        }

        public bool PostCustomerData(string Query)
        {
            return BNIData.Commander.PostData(this._connexionString, this._isOracleData, Query);
        }
    }
}