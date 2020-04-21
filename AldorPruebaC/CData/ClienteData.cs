using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.EntityClient;


namespace CData
{
    public class ClienteData
    {
        private string s = System.Configuration.ConfigurationManager.ConnectionStrings["Clientes_AREntities"].ConnectionString;
        public void Mantenimiento(string Accion, string NOMBRE, int IDENTIFICACION, int Telefono, int Id)
        {
            try
            {               
                System.Data.EntityClient.EntityConnectionStringBuilder e = new System.Data.EntityClient.EntityConnectionStringBuilder(s);
                string ProviderConnectionString = e.ProviderConnectionString;

                SqlConnection con = new SqlConnection(ProviderConnectionString);

                SqlCommand cmd = new SqlCommand("STPR_CLIENTES_PRUEBA_MANTENIMIENTO", con);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add("@ACCION", SqlDbType.VarChar).Value = Accion;
                cmd.Parameters.Add("@NOMBRE", SqlDbType.VarChar).Value = NOMBRE;
                cmd.Parameters.Add("@IDENTIFICACION", SqlDbType.Int).Value = IDENTIFICACION;
                cmd.Parameters.Add("@TELEFONO", SqlDbType.Int).Value = Telefono;
                cmd.Parameters.Add("@ID", SqlDbType.Int).Value = Id;
                cmd.Parameters.Add("@P_Mensaje", SqlDbType.VarChar).Value = "I";

                con.Open();

                cmd.ExecuteNonQuery();

                con.Close();
            }
            catch (Exception ex)
            {
                
            }
        }

       

        public List<CEntidades.CLIENTES> BuscarCliente(string NOMBRE = "")
        {
            List<CEntidades.CLIENTES> listclient = new List<CEntidades.CLIENTES>();
            
            try
            {                
                //cambio de pruebas
                //otro cambio
                System.Data.EntityClient.EntityConnectionStringBuilder e = new System.Data.EntityClient.EntityConnectionStringBuilder(s);
                string ProviderConnectionString = e.ProviderConnectionString;
                string ConnectionString = ConfigurationManager.ConnectionStrings["Clientes_AREntities"].ConnectionString;
                SqlConnection con = new SqlConnection(ProviderConnectionString);
                SqlDataReader reader;

                string query = @"SELECT * FROM [dbo].[FTN_CLIENTES_PRUEBA_LISTA_CLIENTES](@NOMBRE);";

                SqlCommand cmd = new SqlCommand(query, con);
                SqlParameter param1 = new SqlParameter();
                param1.ParameterName = "@NOMBRE";
                param1.SqlDbType = SqlDbType.VarChar;
                param1.Value = NOMBRE;

                cmd.Parameters.Add(param1);

                con.Open();
                reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    CEntidades.CLIENTES client = new CEntidades.CLIENTES();
                    client.ID = int.Parse(reader["ID"].ToString());
                    client.NOMBRE_COMPLETO = reader["NOMBRE_COMPLETO"].ToString();
                    client.IDENTIFICACION = int.Parse(reader["IDENTIFICACION"].ToString());
                    client.TELEFONO = int.Parse(reader["TELEFONO"].ToString());
                    listclient.Add(client);



                }
                con.Close();


            }
            catch (Exception ex)
            {

            }
            return listclient;
        }

        
    }
}
