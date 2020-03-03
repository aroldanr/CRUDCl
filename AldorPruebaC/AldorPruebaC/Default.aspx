<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="AldorPruebaC.Default" enableEventValidation="false"%>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>
<!DOCTYPE html>

<html>
<head runat="server">
    
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>

    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>

   

    <!-- css botones -->
    <style>
        .button {
            background-color: #4CAF50; /* Green */
            border: none;
            color: white;
            padding: 16px 32px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 16px;
            margin: 4px 2px;
            -webkit-transition-duration: 0.4s; /* Safari */
            transition-duration: 0.4s;
            cursor: pointer;
        }

        .btnverde {
            background-color: white;
            color: black;
            border: 2px solid #4CAF50;
        }

            .btnverde:hover {
                background-color: #4CAF50;
                color: white;
            }

        .btnazul {
            background-color: white;
            color: black;
            border: 2px solid #008CBA;
        }

            .btnazul:hover {
                background-color: #008CBA;
                color: white;
            }

        .btnrojo {
            background-color: white;
            color: black;
            border: 2px solid #f44336;
        }

            .btnrojo:hover {
                background-color: #f44336;
                color: white;
            }

        .btngris {
            background-color: white;
            color: black;
            border: 2px solid #e7e7e7;
        }

            .btngris:hover {
                background-color: #e7e7e7;
            }

        .btnnegro {
            background-color: white;
            color: black;
            border: 2px solid #555555;
        }

            .btnnegro:hover {
                background-color: #555555;
                color: white;
            }
    </style>
    <!-- css botones -->

    <script>
        listacl("");
        function BuscarPorNombre() {
          var Name =  document.getElementById("txtbuscar").value;
          listacl(Name);
        }
        function listacl(Nombre) {
            //debugger;
            
            $.ajax({
                type: "POST",
                url: 'Default.aspx/ListarClientes',
                data: "{Nombre:'"+Nombre+"'}",
                contentType: "application/json; charset=utf-8",
                dataType:"json",
                success: function (data) {
                    console.log(data);
                    var retorn = iterarTabla(data.d);
                    console.log(retorn);
                    $('#cuerpotabla').html(retorn);

                },
                failure: function (response) {
                    alert(response.d);
                }
            });
        }


        function iterarTabla(miArray) {
            var retorno = '';

            for (var i = 0; i < miArray.length; i += 1) {
                retorno = retorno + '<tr><td>' + miArray[i].ID + '</td><td>' +
                  miArray[i].IDENTIFICACION + '</td><td>' + miArray[i].NOMBRE_COMPLETO + '</td><td>' +
                    miArray[i].TELEFONO + `</td><td><button id='btnEliminar' type='button' OnClick="Eliminar('${miArray[i].ID}')">Eliminar</button></td><td><button id='btnActualizar' type='button' OnClick="Actualizar('${miArray[i].NOMBRE_COMPLETO}')">Actualizar</button></td></tr>`;
            }
            return retorno;


        }

        function BuscarClienteBD(Nombre) {
            //debugger;
            var retorno;
            $.ajax({
                type: "POST",
                url: 'Default.aspx/ListarClientes',
                data: "{Nombre:'" + Nombre + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async:false,
                success: function (data) {
                    console.log(data);
                    retorno = ArmarRegistro(data.d);              
                    

                },
                failure: function (response) {
                    alert(response.d);
                }
            });
            return retorno;
        }

        function ArmarRegistro(miArray) {
            var retorno = '';

            var Objeto = {
                ID: miArray[0].ID,
                IDENTIFICACION:miArray[0].IDENTIFICACION,
                NOMBRE_COMPLETO:miArray[0].NOMBRE_COMPLETO,
                TELEFONO:miArray[0].TELEFONO
            }
            
            return Objeto;


        }

        function Eliminar(ID) {
            var ActionE = "B";
            var Namee = "";
            //debugger;
            var r = confirm("¿Desea eliminar el registro?");
            if (r == true) {
               $.ajax({
                    type: "POST",
                    url: 'Default.aspx/Mantenimiento',
                    data: "{ID:'" + ID + "', Accion:'" + ActionE + "' , Nombre:'" + Namee + "',Identificacion:'" + 0 + "', Telefono:'" + 0 + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) {
                        console.log(data);                       
                        listacl("");
                    },



                    failure: function (response) {
                        alert(response.d);
                    }
                });
            } else {
                return bool = false;
            }

                
            
        }

        function Actualizar(Nombre) {
            var Objeto = BuscarClienteBD(Nombre);
            document.getElementById("txtnombre").value = Objeto.NOMBRE_COMPLETO;
            document.getElementById("txtindentificacion").value = Objeto.IDENTIFICACION;
            document.getElementById("txttelefono").value = Objeto.TELEFONO;
            document.getElementById("clienId").value = Objeto.ID;
            $('#myModal').modal('show');

            
            
        }

        function confirmar() {
            var txt;
            var bool;
            var r = confirm("Press a button!");
            if (r == true) {
                return bool = true;
            } else {
                return bool = false;
            }

           
        }

        function openModal() {
            
            $('#myModal').modal('show');


        }

        function closeModal() {

            $('#myModal').modal('toggle');
            limpiarTXT();

        }
        function limpiarTXT() {
            document.getElementById("txtnombre").value = "";
            document.getElementById("txtindentificacion").value = "";
            document.getElementById("txttelefono").value = "";
            document.getElementById("clienId").value = 0;

        }

        function Insertar() {
            var Name = document.getElementById("txtnombre").value;
            var idcard = document.getElementById("txtindentificacion").value;
            var telefono = document.getElementById("txttelefono").value;
            var ID = 0;
            ID = document.getElementById("clienId").value;
            debugger;
            var Action = ID > 0 ? "A" : "I";
            
            if ($("#txtnombre").val().length == 0 && $("#txtindentificacion").val().length == 0) {
                alert("El nombre es obligatorio");
               
            }

            else {
                $.ajax({
                type: "POST",
                url: 'Default.aspx/Mantenimiento',
                data: "{ID:'" + ID + "', Accion:'" + Action + "' , Nombre:'" + Name + "',Identificacion:'" + idcard + "', Telefono:'" + telefono + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    console.log(data);
                    listacl("");
                    limpiarTXT();
                    closeModal();
                },
                failure: function (response) {
                    alert(response.d);
                }
            });
            }
     

        }
        

    </script>

</head>
   
  
<body>
   <form id="formcl" runat="server"> <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div class="container" runat="server">
      
        <h2>Panel Clientes</h2>
        <div class="panel-group">
            <div class="panel panel-default">
                <div class="panel-heading">Consulta de Clientes</div>
                <div class="panel-body"></div>

                <div class="form-group">
                    <label for="txtbuscar">Buscar por Nombre Completo</label>
                    <input type="text" class="form-control" id="txtbuscar" placeholder="Search" />

                </div>
               
                <button id="btnnuevo" class="button btnazul" type="button" onclick="openModal()">Nuevo</button>
                <input type="button" value="Buscar" class="button btnverde" onclick="BuscarPorNombre()" />

            <asp:LinkButton ID="ReporteBtn" runat="server"  type="submit" class="button btngris"  OnClick="btnimprimirtodo_Click">Imprimir</asp:LinkButton>
                    <table class="table">
                        <thead>
                            <tr>
                                <th scope="col">#</th>
                                <th scope="col">Identificación</th>
                                <th scope="col">Nombre Completo</th>
                                <th scope="col">Teléfono</th>
                                <th scope="col">Accion</th>
                            </tr>
                        </thead>
                        <tbody id="cuerpotabla">
                            <tr>
                                <th scope="row">1</th>
                                <td>Mark</td>
                                <td>Otto</td>
                                <td>@mdo</td>
                            </tr>
                        </tbody>
                    </table>
               


                <!-- The Modal -->
                <div id="myModal" class="modal fade in" tabindex="-1" role="dialog" >
       <div class="modal-dialog" >
           <div class="modal-content box-color">
               <div class="modal-header">
                                <span class="close">&times;</span>
                                <h2>Mantenimiento de Clientes</h2>
                            </div>
                            <div class="modal-body">

                                
                                    <div class="form-group">
                                        <label for="txtindentificacion">Identificación</label>
                                        <input type="number" class="form-control" id="txtindentificacion"  placeholder="" max="10" oninput="javascript: if (this.value.length > this.maxLength) this.value = this.value.slice(0, this.maxLength);"maxlength = "5" />

                                    </div>
                                    <div class="form-group">
                                        <label for="txtnombre">Nombre Completo</label>
                                        <input type="text" class="form-control" id="txtnombre" runat="server" placeholder="Nombre" />
                                    </div>
                                    <div class="form-group">
                                        <label for="txttelefono">Teléfono</label>
                                        <input type="number" class="form-control" id="txttelefono"  placeholder="####-####" oninput="javascript: if (this.value.length > this.maxLength) this.value = this.value.slice(0, this.maxLength);"maxlength = "8" />
                                    </div>
                                    <button type="button" class="btn btn-primary" onclick="Insertar()">Guardar</button>
                                    <button type="button" class="btn btn-primary" onclick="closeModal()">Cancelar</button>
                                     <asp:LinkButton ID="btnindividual" runat="server"  type="submit" class="btn btn-primary"  OnClick="btnindividual_Click">Imprimir</asp:LinkButton>
                                    <input type="hidden" id="clienId" name="custId" value="0"/>
                               


                            </div>
                            <div class="modal-footer">
                                <h3></h3>
                            </div>
                        </div>
                    </div>
                </div>


            </div>
            
        </div>

        
        <div class="container">
            <h2></h2>
            <div class="panel panel-default">
                <div class="panel-heading">Reportes</div>
                

                <rsweb:ReportViewer ID="ReportViewer1" runat="server" Width="800px" Visible="false" ></rsweb:ReportViewer>
            </div>
        </div>
        
    </div>
       </form>
</body>
       
</html>
