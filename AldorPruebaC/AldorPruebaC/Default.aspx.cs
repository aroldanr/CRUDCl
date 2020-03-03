using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using CNegocio;
using System.Data;
using Microsoft.Reporting.WebForms;

namespace AldorPruebaC
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
            
        }

        [WebMethod]
        public static List<CEntidades.CLIENTES> ListarClientes(string Nombre)
        {
           
            ClienteNegocio neg = new ClienteNegocio();
            List<CEntidades.CLIENTES> clientes = new List<CEntidades.CLIENTES>();
            try
            {
                
               
                if (Nombre.Length > 0)
                {
                    clientes = neg.BuscarCliente(Nombre);
                }
                else
                {
                    clientes = neg.BuscarCliente(Nombre);
                }
               

                return clientes;
            }             
            catch (Exception)
            {

                throw;
            }
            

        }

        [WebMethod]
        public static void Mantenimiento(int ID, string Accion, string Nombre, int Identificacion, int Telefono)
        {

            ClienteNegocio neg = new ClienteNegocio();
            
            try
            {
                neg.Mantenimiento(Accion, Nombre, Identificacion, Telefono, ID);

               
            }
            catch (Exception)
            {

                throw;
            }


        }

        protected void btnimprimirtodo_Click(object sender, EventArgs e)
        {
            ClienteNegocio neg = new ClienteNegocio();
            List<CEntidades.CLIENTES> clientes = new List<CEntidades.CLIENTES>();
            try
            {               
                
                PrintReport(neg.BuscarCliente(""),"Reporte Registro de Clientes General");
               
            }
            catch(Exception err)
            {
                
            }
        }

        public void PrintReport(List<CEntidades.CLIENTES> ListClientes,string TipoReporte)
        {
            try
            {
                if (ListClientes != null)
                {
                    ReportViewer1.Visible = true;
                    ReportViewer1.LocalReport.DataSources.Clear();
                    
                    ReportParameter Titulo = new ReportParameter("TipoReporte", TipoReporte);
                    ReportViewer1.LocalReport.ReportEmbeddedResource = "AldorPruebaC.ReporteClientes.rdlc";
                    ReportViewer1.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource("DataSet1", ListClientes));
                    ReportViewer1.LocalReport.SetParameters(Titulo);
                    ReportViewer1.LocalReport.Refresh();
                }
               
            }
            catch (Exception)
            {

                throw;
            }
         
        }

        protected void btnindividual_Click(object sender, EventArgs e)
        {
            ClienteNegocio neg = new ClienteNegocio();
            List<CEntidades.CLIENTES> clientes = new List<CEntidades.CLIENTES>();
            try
            {

                PrintReport(neg.BuscarCliente(txtnombre.Value),"Reporte Registro de Clientes Individual");

            }
            catch (Exception err)
            {

            }
        }
    }
}