<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Contenu.master" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="GestCredOnline.WebUI.Pages.index" %>


<asp:Content ID="Content1" ContentPlaceHolderID="ContentHead" runat="server">
    <style> 
        .infobox  {
            cursor:pointer;
        }

    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentMain" runat="server">
      <div class="page-body">
        <div class="row">
            <div class="col-sm-12">
                <div class="card">
                    <div class="card-block">

                        
    <div class="row">

        <div class="col-md-6 col-sm-12 col-xs-12">

            <div class="widget-box transparent">
                <div class="widget-header widget-header-flat">
                    <h4 class="widget-title lighter">
                        <i class="ace-icon fa fa-star orange"></i>
                        Demandes en cours de traitement
                    </h4>

                    <div class="widget-toolbar">
                        <!--<a href="#" data-action="collapse">
                            <i class="ace-icon fa fa-chevron-up"></i>
                        </a>-->
                    </div>
                </div>

                <div class="widget-body" style="display: block;">
                    <div class="widget-main no-padding" id="DivProgressRequest">

                    </div><!-- /.widget-main -->
                </div><!-- /.widget-body -->
            </div>

        </div>


        <div class="col-md-6 col-sm-12 col-xs-12">

            <div class="widget-box transparent">
                <div class="widget-header widget-header-flat">
                    <h4 class="widget-title lighter">
                        <i class="ace-icon fa fa-info-circle  red"></i>
                        Demandes en attente de lancement
                    </h4>

                    <div class="widget-toolbar">
                        <!--<a href="#" data-action="collapse">
                            <i class="ace-icon fa fa-chevron-up"></i>
                        </a>-->
                    </div>
                </div>

                <div class="widget-body" style="display: block;">
                    <div class="widget-main no-padding" id="DivWaitingRequest">



                    </div><!-- /.widget-main -->
                </div><!-- /.widget-body -->
            </div>

        </div>

        <div class="col-md-12 col-sm-12 col-xs-12">

            <div class="widget-box transparent">
                <div class="widget-header widget-header-flat">
                    <h4 class="widget-title lighter">
                        <i class="ace-icon fa  fa-headphones  blue"></i>
                        Demandes
                    </h4>

                    <div class="widget-toolbar">
                        <!--<a href="#" data-action="collapse">
                            <i class="ace-icon fa fa-chevron-up"></i>
                        </a>-->
                    </div>
                </div>

                <div class="widget-body" style="display: block;">
                    <div class="widget-main no-padding">
                        <div class="infobox-container" id="DivResume">




                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-12 col-sm-12 col-xs-12">
            <div id="DivDetails"></div>
        </div>



    </div>

                        <div id="divReport">   </div>

                        </div>
                    </div>
                </div>
            </div>
          </div>


</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentFoot" runat="server">
 

<script id="TmplDemandeDetailList" type="text/template">
    <table class="table table-bordered table-striped">
        <thead class="thin-border-bottom">
            <tr>
                <th>
                    <i class="ace-icon fa fa-caret-right blue"></i>Produit
                </th>
                <th class="hidden-480">
                    <i class="ace-icon fa fa-caret-right blue"></i>Montant
                </th>
                <th class="hidden-480">
                    <i class="ace-icon fa fa-caret-right blue"></i>Taux
                </th>
                 <th class="hidden-480">
                    <i class="ace-icon fa fa-caret-right blue"></i>Risque 
                </th>
                <th class="hidden-480">
                    <i class="ace-icon fa fa-caret-right blue"></i>Periodicité de paiement
                </th>
                <th>
                    <i class="ace-icon fa fa-caret-right blue"></i>Date
                </th>
            </tr>
        </thead>
        <tbody>
            {{#lst}}
            <tr>
                <td>
                    <a class="LinkMenuAjax"   href="souscription_details.aspx?ID={{Id}}"> {{Produit}} </a>
                </td>
                <td >
                    {{Montant}}
                </td>
                <td class="hidden-480">
                    {{Taux}} %
                </td>
                  <td class="hidden-480">
                    {{Risque}}
                </td>
                <td class="hidden-480">
                    {{Periodicite}}
                </td>
                <td class="hidden-480">
                    {{DateDemande}}
                </td>
            </tr>
            {{/lst}}
        </tbody>
    </table>

    {{^lst}}
    <div class="alert alert-danger">
        <strong>
            <i class="ace-icon fa fa-times"></i>
        </strong>
        Aucune demande disponible dans cette liste
        <br>
    </div>
    {{/lst}}
</script>

<script id="TmplDemandeList" type="text/template">
    <table class="table table-bordered table-striped">
        <thead class="thin-border-bottom">
            <tr>
                <th>
                    <i class="ace-icon fa fa-caret-right blue"></i>Produit
                </th>
                <th class="hidden-480">
                    <i class="ace-icon fa fa-caret-right blue"></i>Montant
                </th>
                <th>
                    <i class="ace-icon fa fa-caret-right blue"></i>Date
                </th>
            </tr>
        </thead>
        <tbody>
            {{#lst}}
            <tr>
                <td>
                    <a class="LinkMenuAjax" href="souscription_details.aspx?ID={{Id}}"> {{Produit}} </a>
                </td>
                <td class="hidden-480">
                    {{Montant}}
                </td>
                <td>
                    {{DateDemande}}
                </td>
            </tr>
            {{/lst}}
        </tbody>
    </table>

    {{^lst}}
    <div class="alert alert-danger">
        <strong>
            <i class="ace-icon fa fa-times"></i>
        </strong>
        Aucune demande disponible dans cette liste
        <br>
    </div>
    {{/lst}}
</script>

    <script type="text/javascript">    


        'use strict';
        var dahshboard = dahshboard || {};
        dahshboard.CID = 0;
        dahshboard.counts = 0;

        dahshboard.InitializePage = function () {
            //dahshboard.LisEtatRequest();

            dahshboard.lstrequest(appConfig.Status.EnAttente , 5, '#DivWaitingRequest');
            dahshboard.lstrequest(appConfig.Status.EnCours, 5, '#DivProgressRequest');
            dahshboard.count(function () {

                dahshboard.designBottom(appConfig.Status.EnAttente, 'infobox-orange2', 'Demandes en attente de lancement', function () {
                    dahshboard.designBottom(appConfig.Status.Engager, 'infobox-orange ', 'Demandes engagées', function () {
                        dahshboard.designBottom(appConfig.Status.EnCours, 'infobox-blue', 'Demandes en cours de traitement', function () {
                            dahshboard.designBottom(appConfig.Status.Valider, 'infobox-green ', 'Demandes approuvées', function () {
                                dahshboard.designBottom(appConfig.Status.Rejeter, 'infobox-red ', 'Demandes refusées ', function () {
                                    $('.infobox-action').on('click', function () {
                                        var i = $(this).attr('data-status').toString();
                                        dahshboard.lstrequest(i, 10, '#DivDetails');
                                    });
                                });
                            });
                        });
                    });
                });

            });

        };

        dahshboard.LisEtatRequest = function () { 
            let _host = appServiceUrl.odataUrl + '/api/Client';
            let _url = _host + '/GetEtatRequest?id=' + localStorage.getItem('racine');
            getAjax(_url, function (data) {
                let str = "";
                data = JSON.parse(data); 
                //console.log(data);
                $.each(data, function (i, v) {
                //for (let i = 0; i < data.length; i++) {
                //    let v = data[i]; 
                    str += "<div style='width:150px;display:inline-block;border:2px solid red; text-align:center; margin-left:3px'>";
                    str += "<span style='display:block'> " + v.CreditProgram + "</span>";
                    str += "<span style='display:block'>" + appConfig.Status.GetLabel(v.DemandeEtat) + "</span>";
                    str += "<span style='display:block'>" + (v.Risque) + "</span>";
                    str += "<span style='display:block'>" + v.Total + "</span>";
                    str += "</div>";
                      
                });
                
                $('#divReport').html(str);

            });
        }

        dahshboard.lstrequest = function (status, top,  Div) {

            helper.Odata.get("Request?$filter=DemandeEtat eq " + status + " &$expand=ProductProgram($select=libelle)&$orderby=RequestID desc&$top="+ top,
                "#DivShowContent", "#DivShowContent", null, null, function (data) {
                    var lst = [];
                    $.each(data.value, function (i, v) {
                         
                        var d = {};
                        d.Id = v.RequestID;
                        d.Produit = v.ProductProgram.Libelle;
                        d.DateDemande = helper.ToLocalDateString(v.DemandeDate);
                        d.Montant = v.CreditMontant.addthousandSepFr();
                        d.Taux = v.CreditTaux.addthousandSepFr(); 
                        d.Risque = v.Risque;
                        d.Periodicite = appConfig.Periodicite.GetLabelByValue(parseInt(v.CreditPeriodicite));
                        lst.push(d);
                    });

                    var template = $('#TmplDemandeList').html();
                    if (Div === '#DivDetails') { template = $('#TmplDemandeDetailList').html(); }
                    var obj = {};
                    obj.lst = lst;
                    var html = Mustache.to_html(template, obj);
                    $(Div).html(html);
                });
        };

        dahshboard.count = function (callback) {
            helper.Odata.get("Request?$count=true&$top=0",
                "#DivShowContent", "#DivShowContent", null, null, function (data) {
                    

                    dahshboard.counts = parseInt(data["@odata.count"]);
                    
                    if (callback !== null) {
                        callback();
                    }
                });
        };

        dahshboard.designBottom = function (status, classe, titre, callback) {

            helper.Odata.get("Request?$filter=DemandeEtat eq " + status + " &$count=true&$top=0",
                "#DivShowContent", "#DivShowContent", null, null, function (data) {
                    //console.log(data);
                    let o = parseInt(data["@odata.count"]);
                    let percent = parseInt((o / dahshboard.counts) * 100 );
                     
                    //(dahshboard.counts = !0) ? parseInt(( o / dahshboard.counts) * 100) : 0;

                    var _thml = ' <div data-status="' + status + '" class="infobox infobox-action ' + classe + ' infobox-large infobox-dark">' +
                        ' <div class="infobox-progress">' +
                        '  <div class="easy-pie-chart percentage" style="width: 39px; height: 39px; line-height: 38px;" data-percent="' + percent + '" data-size="39">' +
                        '    <span class="percent">' + percent + '</span>%' +
                        '    <canvas width="39" height="39"></canvas>' +
                        '  </div>' +
                        ' </div>' +
                        '<div class="infobox-data">' +
                        '    <div class="infobox-content"> ' + titre + ' </div>' +
                        // '    <div class="infobox-content">Completion</div>'+
                        ' </div>' +
                        '</div>';

                    $('#DivResume').append(_thml);

                    if (callback !== null) {
                        callback();
                    }
                });

        };


        $(document).ready(function () {
            dahshboard.InitializePage();
        });


        function getAjax(url, success) {
            var xhr = window.XMLHttpRequest ? new XMLHttpRequest() : new ActiveXObject('Microsoft.XMLHTTP');
            xhr.open('GET', url);
            xhr.onreadystatechange = function () {
                if (xhr.readyState > 3 && xhr.status == 200) success(xhr.responseText);
            };
            xhr.setRequestHeader('X-Requested-With', 'XMLHttpRequest');
            xhr.send();
            return xhr;
        }
    </script>

</asp:Content>
