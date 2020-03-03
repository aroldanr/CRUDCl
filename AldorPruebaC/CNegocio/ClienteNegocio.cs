using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CNegocio
{
    public class ClienteNegocio
    {
        public void Mantenimiento(string Accion, string NOMBRE, int IDENTIFICACION, int Telefono, int Id)
        {
            CData.ClienteData dta = new CData.ClienteData(); 
            try
            {
                dta.Mantenimiento(Accion, NOMBRE, IDENTIFICACION, Telefono, Id);
            }
            catch (Exception ex)
            {

            }
        }

       
        public List<CEntidades.CLIENTES> BuscarCliente(string NOMBRE)
        {
            CData.ClienteData dta = new CData.ClienteData();
           
                return dta.BuscarCliente(NOMBRE);
                        
        }
    }
}
