using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Data.SqlClient;
using System.Data.OracleClient;

namespace GestCredOnline.BNIData
{
    public class Commander
    {
        public static DataTable GetData(String ConnexionString, bool isOracleConnexion, String Query)
        {
            DataSet ds = new DataSet();

            if (!isOracleConnexion)
            {
                SqlConnection conSQL = null;
                SqlDataAdapter daSQL = null;
                try
                {
                    conSQL = new SqlConnection(ConnexionString);
                    conSQL.Open();

                    using (SqlCommand Cmd = new SqlCommand())
                    {
                        Cmd.Connection = conSQL;
                        Cmd.CommandType = CommandType.Text;
                        Cmd.CommandTimeout = 60;
                        Cmd.CommandText = Query;

                        daSQL = new SqlDataAdapter(Cmd);
                        daSQL.Fill(ds, "Table1");

                        return ds.Tables[0];
                    }
                }
                catch (Exception ex)
                {
                    throw ex;
                }
                finally
                {
                    if (daSQL != null) { daSQL.Dispose(); }
                    SqlConnection.ClearPool(conSQL);
                    conSQL.Close();
                }

            }
            else
            {
                OracleConnection conOracle = null;
                OracleDataAdapter daOracle = null;
                try
                {

                    conOracle = new OracleConnection(ConnexionString);
                    conOracle.Open();

                    using (OracleCommand Cmd = new OracleCommand())
                    {
                        Cmd.Connection = conOracle;
                        Cmd.CommandType = CommandType.Text;
                        Cmd.CommandTimeout = 60;
                        Cmd.CommandText = Query;

                        daOracle = new OracleDataAdapter(Cmd);
                        daOracle.Fill(ds, "Table1");


                        return ds.Tables[0];
                    }
                }
                catch (Exception ex)
                {
                    throw ex;
                }
                finally
                {
                    if (daOracle != null) { daOracle.Dispose(); }
                    OracleConnection.ClearPool(conOracle);
                    conOracle.Close();
                }
            }
        }
         
        public static bool PostData(String ConnexionString, bool isOracleConnexion, String Requete)
        {
            DataSet ds = new DataSet();

            if (!isOracleConnexion)
            {
                SqlConnection conSQL = null;
                SqlDataAdapter daSQL = null;
                try
                {
                    conSQL = new SqlConnection(ConnexionString);
                    conSQL.Open();

                    using (SqlCommand Cmd = new SqlCommand())
                    {
                        Cmd.Connection = conSQL;
                        Cmd.CommandType = CommandType.Text;
                        Cmd.CommandTimeout = 60;
                        Cmd.CommandText = Requete;

                        Cmd.ExecuteNonQuery();
                        return true;
                    }
                }
                catch (Exception ex)
                {
                    throw ex;
                }
                finally
                {
                    if (daSQL != null) { daSQL.Dispose(); }
                    SqlConnection.ClearPool(conSQL);
                    conSQL.Close();
                }

            }
            else
            {
                OracleConnection conOracle = null;
                OracleDataAdapter daOracle = null;
                try
                {

                    conOracle = new OracleConnection(ConnexionString);
                    conOracle.Open();

                    using (OracleCommand Cmd = new OracleCommand())
                    {
                        Cmd.Connection = conOracle;
                        Cmd.CommandType = CommandType.Text;
                        Cmd.CommandTimeout = 60;
                        Cmd.CommandText = Requete;

                        Cmd.ExecuteNonQuery();
                        return true;
                    }
                }
                catch (Exception ex)
                {
                    throw ex;
                }
                finally
                {
                    if (daOracle != null) { daOracle.Dispose(); }
                    OracleConnection.ClearPool(conOracle);
                    conOracle.Close();
                }
            }
        }


    }
}
