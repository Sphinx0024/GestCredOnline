<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/NoLogging.master" AutoEventWireup="true" CodeBehind="simul_prospect.aspx.cs" Inherits="GestCredOnline.WebAPI.Pages.simul_prospect" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentHead" runat="server">
    <link type="text/css" href="/Assets/lib/jquery.steps/jquery.steps.css" rel="stylesheet" />
    <style>
        .fontEcriture {
            font-weight: bolder;
            font-size: 15px;
        }

        .wizard > .content {
            min-height: 40em !important;
        }

        label {
            display: block;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentMain" runat="server">

    <div class="page-body">
        <div class="row">
            <div class="col-sm-12">
                <div class="card">
                    <div class="card-block">
                        
                          
                                        <input type="hidden" class="form-control" id="TxtRacine" placeholder="Votre racine client" />

                      

                        <form class="wizard-form fontEcriture" id="basic-forms" action="#">
                            <h3 class="header smaller lighter green"><i class="ace-icon fa fa-inbox "></i>Informations  </h3>
                              <ul class="list-unstyled spaced2"> 
                            <li class="muted"> 
                                Client  : <b id="bRacine"></b> 
                            </li> 
                        </ul>
                            <div class="row">

                                <!--<h3>Client </h3>
                                            <fieldset>
                                                <em class="message_asterisk">Les champs suivis d'un asterisk (*) sont obligatoires</em>
                                                <div class="form-group row">
                                                    <div class="col-sm-4">
                                                        <label for="nom_client"
                                                            class="block">
                                                            Nom <i class="danger">*</i>

                                                        </label>
                                                        <input id="nom_client"
                                                            name="nom_client" required type="text"
                                                            class=" form-control">
                                                    </div>
                                                    <div class="col-sm-4">
                                                        <label for="prenoms_client"
                                                            class="block">
                                                            Prénoms <i class="danger">*</i>
                                                        </label>
                                                        <input id="prenoms_client" required
                                                            name="prenoms_client" type="text"
                                                            class=" form-control">
                                                    </div>


                                                    <div class="col-sm-4">
                                                        <label for="nationnalite"
                                                            class="block">
                                                            Nationnalité <i class="danger">*</i>
                                                        </label>

                                                        <select id="nationnalite" required
                                                            name="nationnalite"
                                                            class=" form-control">
                                                            <option value="">Choisir la nationalité</option>
                                                            <option value="IVOIRIENNE">IVOIRIENNE</option>
                                                            <option value="ETRANGERE">ETRANGERE</option>
                                                        </select>

                                                    </div>


                                                </div>


                                                <div class="form-group row">

                                                    <div class="col-sm-3">
                                                        <label for="telephone"
                                                            class="block">
                                                            Telephone <i class="danger">*</i>

                                                        </label>
                                                        <input id="telephone" required
                                                            name="telephone" type="text"
                                                            class=" form-control">
                                                    </div>
                                                    <div class="col-sm-3">
                                                        <label for="numpiece"
                                                            class="block">
                                                            Numéro de Pièce <i class="danger">*</i>

                                                        </label>
                                                        <input id="numpiece" required
                                                            name="numpiece" type="text"
                                                            class=" form-control">
                                                    </div>
                                                    <div class="col-sm-3">
                                                        <label for="datenais"
                                                            class="block">
                                                            Date de Naissance <i class="danger">*</i>

                                                        </label>
                                                        <input id="datenais" required
                                                            name="datenais" type="date"
                                                            class=" form-control">
                                                    </div>
                                                    <div class="col-sm-3">
                                                        <label for="datenais"
                                                            class="block">
                                                            Date de Naissance <i class="danger">*</i>

                                                        </label>
                                                        <input id="datenais" required
                                                            name="datenais" type="date"
                                                            class=" form-control">
                                                    </div>

                                                </div>


                                            </fieldset>-->

                                <div class="col-md-3 col-sm-3 col-sx-12">
                                    <div class="form-group">
                                        <label for="TxtNom">Nom</label>
                                        <input type="text" class="form-control" id="TxtNom" placeholder="Votre nom" />
                                    </div>
                                </div>

                                <div class="col-md-3 col-sm-3 col-sx-12">
                                    <div class="form-group">
                                        <label for="TxtPrenom">Prénoms</label>
                                        <input type="text" class="form-control" id="TxtPrenom" placeholder="Votre prenom" />
                                    </div>
                                </div>

                                <div class="col-md-3 col-sm-3 col-sx-12">
                                    <div class="form-group">
                                        <label for="TxtTelephone">Telephone</label>
                                        <input type="text" class="form-control" id="TxtTelephone" placeholder="Votre téléphone" />
                                    </div>
                                </div>

                                <div class="col-md-3 col-sm-3 col-sx-12">
                                    <div class="form-group">
                                        <label for="TxtNationnalité">Nationnalité</label>
                                        <select id="nationnalite" required name="nationnalite" class=" form-control">
                                               <option value="">Choisir la nationalité</option>
                                               <option value="IVOIRIENNE">IVOIRIENNE</option>
                                               <option value="ETRANGERE">ETRANGERE</option>
                                        </select>
                                     </div>
                                </div>

                                <div class="col-md-3 col-sm-3 col-sx-12">
                                    <div class="form-group">
                                        <label for="TxtNumPiece">Numéro de Pièce</label>
                                        <input type="text" class="form-control" id="TxtNumPiece" placeholder="Votre numéro de pièce" />
                                    </div>
                                </div>

                                <div class="col-md-3 col-sm-3 col-sx-12">
                                    <div class="form-group">
                                        <label for="TxtDateNais">Date de Naissance</label>
                                        <input type="date" class="form-control" id="TxtDateNais" placeholder="Votre date de naissance" />
                                    </div>
                                </div>

                                <div class="col-md-3 col-sm-3 col-sx-12">
                                    <div class="form-group">
                                        <label for="TxtDateEtablissement">Date Etablissement de la Pièce</label>
                                        <input type="date" class="form-control" id="TxtDateEtablissement" placeholder="La date d'établissement de la pièce" />
                                    </div>
                                </div>

                                <div class="col-md-3 col-sm-3 col-sx-12">
                                    <div class="form-group">
                                        <label for="TxtDateExpiration">Date Expiration de la Pièce</label>
                                        <input type="date" class="form-control" id="TxtDateExpiration" placeholder="La date d'expiration de la pièce" />
                                    </div>
                                </div>

                                <div class="col-md-6 col-sm-6 col-sx-12">
                                    <div class="form-group">
                                        <label for="TxtDateFinContrat">Date du debut de son contrat</label>
                                        <input type="date" class="form-control" id="TxtDateEDebutContrat"  />
                                    </div>
                                </div>

                                <div class="col-md-6 col-sm-6 col-sx-12">
                                    <div class="form-group">
                                        <label for="TxtDateFinContrat">Date Expiration de la Pièce</label>
                                        <input type="date" class="form-control" id="TxtDateFinContrat" />
                                    </div>
                                </div>

                                <div class="col-md-8 col-sm-8 col-sx-12">
                                    <div class="form-group">
                                        <label for="CmbProduct">Produit</label>
                                        <select class="chosen-select" id="CmbProduct" data-placeholder="choisir votre produit...">
                                            <option value="0">.choisir votre produit... </option>
                                        </select>
                                    </div>
                                </div>

                                <div class="col-md-4 col-sm-4 col-sx-12">
                                    <div class="form-group">
                                        <label for="TxtTaux">Taux</label>
                                        <input type="text" class="form-control autoNumeric form-control-taux" id="TxtTaux" readonly placeholder="Taux du produit" />
                                        <input type="hidden" class="form-control  form-control-taux" id="TxtTauxEndettement" readonly placeholder="Taux du produit" />
                                    </div>
                                </div>

                              

                                  <div class="col-md-4 col-sm-6 col-sx-12">
                                    <div class="form-group">
                                        <label for="TxtSalaire">Profession</label>
                                        <select id="cmbProfession" class="chosen-select">
                                            <option value="0">Choisir votre profession</option>
                                            <option value="1">ENSEIGNANT DU PUBLIC</option>
                                            <option value="2">ENSEIGNANT DU PRIVE</option>
                                            <option value="3">FONCTIONNAIRE</option>
                                            <option value="4">SALARIE DU PRIVE</option>
                                        </select>
                                    </div>
                                </div>

                                <div class="col-md-4 col-sm-6 col-sx-12">
                                    <div class="form-group">
                                        <label for="TxtSalaire">Salaire Net</label>
                                        <input type="text" value="0" class="form-control autoNumeric form-control-montant" id="TxtSalaire" placeholder="Montant à emprunter" />
                                    </div>
                                </div>

                                <div class="col-md-4 col-sm-6 col-sx-12">
                                    <div class="form-group">
                                        <label for="TxtRevenusLocatifs">Revenus locatifs</label>
                                        <input type="text" value="0" class="form-control autoNumeric form-control-montant" id="TxtRevenusLocatifs" placeholder="Montant à emprunter" />
                                    </div>
                                </div>

                                <div class="col-md-4 col-sm-6 col-sx-12">
                                    <div class="form-group">
                                        <label for="TxtRevenusAgricoles">Revenus agricoles</label>
                                        <input type="text" value="0" class="form-control autoNumeric form-control-montant" id="TxtRevenusAgricoles" placeholder="Montant à emprunter" />
                                    </div>
                                </div>

                                <div class="col-md-4 col-sm-6 col-sx-12">
                                    <div class="form-group">
                                        <label for="TxtRevenusAutres">Autres revenus</label>
                                        <input type="text" value="0" class="form-control autoNumeric form-control-montant" id="TxtRevenusAutres" placeholder="Montant à emprunter" />
                                    </div>
                                </div>

                                <div class="col-md-4 col-sm-6 col-sx-12">
                                    <div class="form-group">
                                        <label for="TxtRevenusTotal">Total des Revenus</label>
                                        <input type="text" value="0" class="form-control autoNumeric form-control-montant" readonly id="TxtRevenusTotal" placeholder="Montant à emprunter" />
                                    </div>
                                </div>

                                <div class="col-md-4 col-sm-6 col-sx-12">
                                    <div class="form-group">
                                        <label for="TxtMontant">Montant à emprunter</label>
                                        <input type="text" class="form-control autoNumeric form-control-montant" value="0" id="TxtMontant" placeholder="Montant à emprunter" />
                                        <input type="hidden" class="form-control  form-control-taux" id="TxtMontantEcheance" readonly placeholder="Taux du produit" />
                                    </div>
                                </div>

                                  <div class="col-md-4 col-sm-6 col-sx-12">
                                    <div class="form-group">
                                        <label for="TxtAutreEngagement">Autres engagments</label>
                                        <input type="text" class="form-control autoNumeric form-control-montant" value="0" id="TxtAutreEngagement" placeholder="Montant à emprunter" />
                                         <input type="hidden" class="form-control  form-control-taux" id="TxtQuotite" readonly placeholder="Taux du produit" />
                                    </div>
                                </div>

                                <div class="col-md-4 col-sm-4 col-sx-12">
                                    <div class="form-group">
                                        <label for="TxtDuree">Periodicité de remboursement </label>
                                        <select class="chosen-select" id="CmbPeriodicite" data-placeholder="choisir la périodicité ...">
                                            <option value="0">... </option>
                                        </select>
                                        <!--<select id="CmbPeriodicite" class="chosen-select">
                                            <option value="0">Choisir votre profession</option>
                                            <option value="1">ENSEIGNANT DU PUBLIC</option>
                                            <option value="2">ENSEIGNANT DU PRIVE</option>
                                            <option value="3">FONCTIONNAIRE</option>
                                            <option value="4">SALARIE DU PRIVE</option>
                                        </select>-->
                                    </div>
                                </div>


                                <div class="col-md-4 col-sm-4 col-sx-12">
                                    <div class="form-group">
                                        <label for="TxtDuree">Duree  (en mois)</label>
                                        <input type="text"  class="form-control autoNumeric form-control-duree" id="TxtDuree" placeholder="Duree de remboursement">
                                    </div>
                                </div>

                                <div class="col-md-4 col-sm-4 col-sx-12">
                                    <div class="form-group">
                                        <label for="TxtDuree">Date de premier versement </label>
                                        <input type="text" class="form-control Date form-control-duree" id="TxtDate1Versement" placeholder="Date de premier versement">
                                    </div>
                                </div>

                                 <!--<div id="DivChkAgricol" class="col-md-3 col-sm-4 col-sx-12">
                                    <div class="form-group">
                                        <span> Etes vous un exploitant agricol ?  </span>
                                        <br />
                                        <div>   
                                            <input type="radio" id="chkAgricolOUI" name="chkAgricol" value="OUI">
                                            <label style="display:inline-block; margin-right:5px" for="OUI">OUI</label> 
                                            <input type="radio" id="chkAgricolNON" name="chkAgricol" value="NON">
                                            <label style="display:inline-block; margin-right:5px" for="NON">NON</label>
                                        </div>
                                       
                                    </div>
                                </div>-->

                                <div class="col-md-3 col-sm-4 col-sx-12">
                                    <div class="form-group">
                                        <br />
                                       
                                    </div>
                                </div>

                              


                                <div class=" col-md-6 col-sm-6 col-xs-12">
                                    <div id="DivSimulation" style="max-height: 250px; overflow-y: scroll"></div>
                                </div>
                                  <div class="col-md-6 col-sm-6 col-sx-12">
                                    <div class="form-group">
                                        <br />  
                                        
                                         <button id="btnSimule" style="border: 1px solid #00ff21" class="btn btn-primary pull-right btn-lg" type="button">voir la simulation de paiements</button>
                                    </div>
                                </div>
                            </div>


                        </form>

                    </div>
                </div>
            </div>
        </div>
    </div>


</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentFoot" runat="server">

    <script>

        'use strict';
        var add_prospect = add_prospect || {};
        add_prospect.CID = 0;
         
        add_prospect.InitializePage = function () {
            add_prospect.InitControle();
        };

        add_prospect.InitControle = function () {
            //$('#DivChkAgricol').hide();

            $('#TxtDate1Versement').val();

            add_prospect.initPeriodicitelisting(function () {
                add_prospect.getproduct(function () { 
                    $('#bRacine').html(localStorage.getItem(appConfig.profileName)  +' - '+localStorage.getItem('racine'));
                    $('#TxtRacine').val(localStorage.getItem('racine')).attr('readonly', true);
                    appHelper.InitAutoNumeric(".autoNumeric");
                    appHelper.InitDatePicker(".Date");
                    $('#btnSimule').on('click', function () { 
                        add_prospect.ValidationFormulaire(function () {  
                            let D = ($('#TxtDate1Versement').val());
                            let T = parseFloat($('#TxtTaux').autoNumeric('get'));
                            let M = parseInt($('#TxtMontant').autoNumeric('get'));
                            let d = parseInt($('#TxtDuree').autoNumeric('get'));
                            let P = appConfig.Periodicite.GetNombreMois(parseInt($('#CmbPeriodicite').val()));
                            add_prospect.calculSimulation(D, P, d, T, M);
                           
                        });
                    });


                    $("#TxtSalaire, #TxtRevenusLocatifs, #TxtRevenusAgricoles, #TxtRevenusAutres").change(function () {
                        add_prospect.CalculerTotalRevenus();
                    });
                     

                });
            });
        };
         
        add_prospect.CalculerTotalRevenus = function () {

            $("#TxtRevenusTotal").autoNumeric('set',
                parseInt($("#TxtSalaire").autoNumeric('get')) +
                parseInt($("#TxtRevenusLocatifs").autoNumeric('get')) +
                parseInt($("#TxtRevenusAgricoles").autoNumeric('get')) +
                parseInt($("#TxtRevenusAutres").autoNumeric('get')));

            if (parseInt($("#TxtRevenusAgricoles").autoNumeric('get')) == 0) {
                $('#DivChkAgricol').hide();
                $('#chkAgricolNON').prop('checked', true);
            } else {
                $('#DivChkAgricol').show();
            }
        };
         
        add_prospect.getproduct = function (callBack) {
            helper.Odata.get("ProductProgram", appConfig.divMainContent, appConfig.divMainContent, null, null, function (data) {
                var opt = "";
                opt += "<option data-taux='0' data-duree='0' value='0'> Choisir le type de produit </option>";
                $.each(data.value, function (i, d) {
                    opt += "<option data-taux='" + d.Taux + "' data-duree='" + d.Duree + "' value='" + d.ProductID + "'>" + d.Libelle + "</option>";
                });
                $('#CmbProduct').html(opt);

                appHelper.InitChoosen('.chosen-select');

                $('#CmbProduct').chosen().change(function (e, i) {
                    var opt = "#CmbProduct option[value='" + i.selected + "']";
                    opt = $(opt);
                    console.log(opt);
                    $('#TxtTaux').autoNumeric('set', opt.attr('data-taux').toString());
                    $('#TxtDuree').autoNumeric('set', opt.attr('data-duree').toString());
                });

                if (callBack !== null) {
                    callBack();
                }
            });
        };

        add_prospect.initPeriodicitelisting = function (callback) {
            var html = "";
            $.each(appConfig.Periodicite, function (key, value) {
                if (!helper.isFunction(value)) {
                    //if (value  === "Mensuelle") {
                    //    html += "<option  selected='selected' value='" + value + "'>" + key + "</option>";
                    //} else
                    {
                        html += "<option  value='" + value + "'>" + key + "</option>";
                    }

                }
            });
            $("#CmbPeriodicite").html(html);
            if (callback !== null) {
                callback();
            }
        };

        add_prospect.calculSimulation = function (Depart, Periodicite, Duree, Taux, Montant) {

            var RetourHTML = "";
            var NbMois = 0;
            var DateDepart = new Date();
            var NPA = 1; var PER = 0; var TPS = 10; var T = 10; var M = 10; var D = 10;
            var Amort = 0; var Amort1 = 0; var AmortCumul = 0;
            var Interet = 0; var AmortCumulA = 0; var MTPS = 0;
            var Assurance = 0; var Annuite = 0;
            var CapitalRestant = 0;
            var TEG = 0;
            var BackGround = "TRListeTexte";
             
            //DateDepart = DateTime.Parse(DateTime.Now.Year.ToString() + "/" + (DateTime.Now.Month + 1).ToString() + "/01");
            //DateDepart = DateDepart.AddDays(-1);

            DateDepart = new Date(helper.ReturnInternationnalDate (Depart, 'FR', '/'));

            RetourHTML += "<table width='100%' class='table table-bordered table-hover' cellpadding='0' cellspacing='0'>";

            RetourHTML += "<tr align='left' valign='top'>";
            //RetourHTML += "<td width='40px' align='center'></td>";
            RetourHTML += "<td colspan='9' style='backgroud-color:#1522'><h3>Ce tableau d'amortissement est à titre indicatif</h3></td>";
            RetourHTML += "</tr>";

            RetourHTML += "<tr align='left' valign='top' class='TRListeEntete'>";
            RetourHTML += "<td width='40px' align='center'>N° Ech</td>";
            RetourHTML += "<td width='70px' align='center'>Date</td>";
            RetourHTML += "<td width='100px' align='right'>Amort</td>";
            RetourHTML += "<td width='100px' align='right'>Amort. Cumul</td>";
            RetourHTML += "<td width='70px' align='right'>Interêt</td>";
            //RetourHTML += "<td width='70px' align='right'>Assurance</td>";
            RetourHTML += "<td width='70px' align='right'>TPS</td>";
            RetourHTML += "<td width='70px' align='right'>Annuité</td>";
            RetourHTML += "<td width='100px' align='right'>Capital Rest.</td>";
            RetourHTML += "</tr>";

            
            PER = parseFloat(NPA / Periodicite);
            NbMois = parseInt((Math.round(Duree * PER)).toString());

            T = (Taux / 100);
            M = Montant;
            D = Duree;
            TPS = 0.1;

            console.log(PER, NPA, Periodicite, NbMois, Duree, TPS)

            for (var i = 1; i <= NbMois; i++) {
                if (i === 1) {
                    var Interm = 0; var Interm2 = 0;
                    Interm = parseFloat(M * ((T / PER) + (T * TPS) / PER));
                    //Interm = Interm * M;

                    Interm2 = parseFloat(1 + (T / PER) + (T * TPS / PER));

                    Amort = (Interm) / (Math.pow(Interm2, (PER * D)) - 1);
                    Amort1 = Amort;
                    Interet = parseFloat(M * T / PER);
                    MTPS = parseFloat(Interet * TPS);

                    //Assurance = (M * 10) / 12;
                    Assurance = (M * 0) / 12;
                    Annuite = Amort + Interet + Assurance + MTPS; 
                    TEG = (Annuite - (M * T) / (PER * (Math.pow((1 + T / PER), (D * PER)) - 1))) * (PER / M);
                    TEG = Math.round(TEG, 2) * 100;
                }
                else {
                    Amort = Amort1 * (Math.pow((1 + (T / PER) + ((TPS * T) / PER)), (i - 1)));
                    Interet = ((M - AmortCumul) * (T / PER));
                }
                AmortCumul += Amort;
                CapitalRestant = Montant - AmortCumul;

                RetourHTML += "<tr align='left' valign='top' class='" + BackGround + "'>";
                RetourHTML += "<td align='center' width='40px'>" + i + "</td>";
                RetourHTML += "<td align='center' width='70px'>" + new Date(DateDepart).toLocaleDateString() + "</td>";
                RetourHTML += "<td width='100px' align='right'>" + (Math.round(Amort).toString()) + "</td>";
                RetourHTML += "<td width='100px' align='right'>" + (Math.round(AmortCumul).toString()) + "</td>";
                RetourHTML += "<td width='70px' align='right'><font class='EnteteSimulation'>" + (Math.round(Interet).toString()) + "</font></td>";
                RetourHTML += "<td width='70px' align='right'><font class='EnteteSimulation'>" + (Math.round((Interet * (TPS / 100))).toString()) + "</font></td>";
                RetourHTML += "<td width='70px' align='right'><font class='EnteteSimulation'>" + (Math.round(Annuite).toString()) + "</font></td>";
                RetourHTML += "<td width='100px' align='right'><font class='EnteteSimulation'>" + (Math.round(CapitalRestant).toString()) + "</font></td>";
                RetourHTML += "</tr>";

                // BackGround = (BackGround === "TRListeTexte" ? "TRListeTexteAltern" : "TRListeTexte");

                if (i < NbMois) {
                    DateDepart = new Date(DateDepart);
                    DateDepart = DateDepart.setMonth(new Date(DateDepart).getMonth() + Periodicite);
                }
            }


            RetourHTML += "</table>";
             
            $("#TxtMontantEcheance").val(Annuite);
            let Te = (parseFloat($("#TxtMontantEcheance").val()) / parseFloat($("#TxtRevenusTotal").autoNumeric('get')));
            $("#TxtTauxEndettement").val(Te);
            // RetourHTML += "#SX#" + Math.round(Annuite) + "#SX#" + DateDepart.ToString("dd/MM/yyyy") + "#SX#" + Math.round(TEG, 2) + "#SX#";
            let Quotite = (((parseInt($("#TxtMontantEcheance").val()) +
                parseInt($("#TxtAutreEngagement").autoNumeric('get'))) * 100) / parseInt($("#TxtRevenusTotal").autoNumeric('get')));

            $("#TxtQuotite").val(Quotite);

            let str = '<p class="lead">Votre quotité est : ' + Quotite.toString() + '</p> <br/>';
            if (Quotite > 33.33) {
                //str += '<b class="text-error" style="color:red">Vous ne pourrez pas avoir accès à ce crédit car vous ne respectez pas la quotité requise </b> <br/>';
                str += '<div class="alert alert-danger"> <strong><i class="ace-icon fa fa-times"></i></strong>Vous ne pourrez pas avoir accès à ce crédit car vous ne respectez pas la quotité requise<br></div> ';

            }
            RetourHTML = str + RetourHTML;


            let dgl = bootbox.dialog({
                title: '',
                message: RetourHTML,
                size: 'large',
                onEscape: true,
                backdrop: true
            });

            dgl.init(function () {
                $('.modal-content').css('max-height', '600px');
                $('.modal-content').css('overflow', 'auto');
            });

            //$('#DivSimulation').html(RetourHTML);

        };

        add_prospect.save = function ( PersonID,  callback) {
            var d = {};
            d.RequestID = 0;
            d.CreditObjet = $('#CmbProduct option:selected ').text();
            d.CreditMontant = parseInt($('#TxtMontant').autoNumeric('get'));
            d.CreditTaux = parseFloat($('#TxtTaux').autoNumeric('get'));
            d.CreditProgramID = parseInt($('#CmbProduct').val());
            d.CreditProgram = $('#CmbProduct option:selected ').text();
            d.DemandeEtat = appConfig.Status.EnAttente;
            d.DemandeDate = new Date();
            d.CreditDatePremVersement = new Date(helper.ReturnInternationnalDate($('#TxtDate1Versement').val(), 'FR','/')   )
            d.AccountRacine = $('#TxtRacine').val();
            d.CreditDuree = parseInt($('#TxtDuree').autoNumeric('get'));
            d.PersonID = PersonID;
            d.SyncStatut = appConfig.StatusSync.adding;
            d.CreditPeriodicite = parseInt($('#CmbPeriodicite').val());
            d.CreditTauxEndettement = parseFloat($('#TxtTauxEndettement').val());
            d.AcompteEpargne = null;
            d.AncienneteClient = null;
            d.Reference = null;
            d.SPItemID = null;
            d.DemandeDossier = null;
            d.AccountNumber = null;
            d.CreditMontantAvance = null;
            d.CreditMontantEcheance = parseInt( $("#TxtMontantEcheance").val());
            d.CreditMontantLettre = null;
            d.CreditQuotite = parseFloat($('#TxtQuotite').val());
            d.Score = null;
            d.Note = null;
            d.Risque = null;
            d.Ref_req = "O";
            helper.Odata.save("Request", d, function (data) {
                add_prospect.CID = data.RequestID;
                if (callback !== null) {
                   callback();
                }
            });
        };

        add_prospect.saveClient = function (callback) {
            //let _estExploitantAgricole = $('#chkAgricolNON').is('checked');

            let d = {
                PersonID: 0,
                Nom: null,
                Prenom: null,
                AccountRacine: localStorage.getItem('racine'),
                Sexe: null,
                Civilite: null,
                DateNaissance: null,
                LieuNaissance: null,
                PieceTypeID: null,
                PieceNumero: null,
                PieceDateEtablissement: null,
                PieceDateExpiration: null,
                HomePhone: null,
                OfficePhone: null,
                CellPhone: null,
                AddressVille: null,
                AddressQuartier: null,
                AddressLot: null,
                RegimeMatrimonialID: null,
                ConjointNom: null,
                ConjointPrenom: null,
                ConjointDomicil: null,
                ConjointPhone: null,
                EmployeurNom: null,
                EmployeurContratID: null,
                EmployeurDateEmbauche: null,
                Profession: $('#cmbProfession').val(),
                EmployeurAdrPost: null,
                EmployeurAdrGeo: null,
                EmployeurPhone: null,
                Salaire: parseInt($("#TxtSalaire").autoNumeric('get')),
                RevenuLocatif: parseInt($("#TxtRevenusLocatifs").autoNumeric('get')),
                RevenuAgricole: parseInt($("#TxtRevenusAgricoles").autoNumeric('get')),
                RevenuAutre: parseInt($("#TxtRevenusAutres").autoNumeric('get')),
                RevenuTotal: parseInt($("#TxtRevenusTotal").autoNumeric('get')),
                EmployeurDateFinContrat: null,
                NbEnfant: null,
                EmployeurFonction: null,
                EmployeurMatricule: null,
                EmployeurProfession: null,
                EmployeurCrade: null,
                EmployeurNbAnneeExiste: null,
                EmployeurEstAgree: null,
                EmployeurSegment: null,
                //EstExploitantAgricole: _estExploitantAgricole,
                Nationalite: null
            };

           

            helper.Odata.save("Clients", d, function (data) { 
                if (callback !== null) {
                    callback(data.PersonID);
                }
            });
            

        }

        /*add_prospect.saveProspect = function (callback) {
            //let _estExploitantAgricole = $('#chkAgricolNON').is('checked');


            let don = {
                ID: 0,
                Nom: $('#TxtNom').val(),
                Prenom: $('#TxtNom').val(),
                AccountRacine: 'Prospect',
                Civilite: null,
                DateNaissance: CreditDatePremVersement = new Date(helper.ReturnInternationnalDate($('#TxtDateNais').val(), 'FR', '/')),
                PieceTypeID: null,
                PieceNumero: $('#TxtNumPiece').val(),
                PieceDateEtablissement: CreditDatePremVersement = new Date(helper.ReturnInternationnalDate($('#TxtDateEtablissement').val(), 'FR', '/')),
                PieceDateExpiration: CreditDatePremVersement = new Date(helper.ReturnInternationnalDate($('#TxtDateExpiration').val(), 'FR', '/')),
                CellPhone: $('#TxtTelephone').val(),
                RegimeMatrimonialID: null,
                EmployeurContratID: null,
                EmployeurDateEmbauche: null,
                Salaire: parseInt($("#TxtSalaire").autoNumeric('get')),
                RevenuLocatif: parseInt($("#TxtRevenusLocatifs").autoNumeric('get')),
                RevenuAgricole: parseInt($("#TxtRevenusAgricoles").autoNumeric('get')),
                RevenuAutre: parseInt($("#TxtRevenusAutres").autoNumeric('get')),
                RevenuTotal: parseInt($("#TxtRevenusTotal").autoNumeric('get')),
                EmployeurDateFinContrat: null,
                Nationalite: null,
                CreditMontant = parseInt($('#TxtMontant').autoNumeric('get')),
                CreditTaux = parseFloat($('#TxtTaux').autoNumeric('get')),
                CreditProgramID = parseInt($('#CmbProduct').val()),
                CreditProgram = $('#CmbProduct option:selected ').text(),
                CreditDuree = parseInt($('#TxtDuree').autoNumeric('get')),
                CreditPeriodicite = parseInt($('#CmbPeriodicite').val()),
                CreditMontantAvance = null;
                CreditMontantEcheance = parseInt($("#TxtMontantEcheance").val()),
                CreditQuotite = parseFloat($('#TxtQuotite').val()),
                CreditTauxEndettement = parseFloat($('#TxtTauxEndettement').val()),
                CreditDatePremVersement = new Date(helper.ReturnInternationnalDate($('#TxtDate1Versement').val(), 'FR', '/'))
            };

            helper.Odata.save("Prospects", don, function (data) {
                if (callback !== null) {
                    callback(data.ID);
                }
            });


        }*/

        add_prospect.ValidationFormulaire = function (callBack) {
            let msg = '';

            if ($('#TxtRacine').val() == '') {
                msg += "<li>Vous devez indiquer votre racine client</li>";
            }

            if ($('#CmbProduct option:selected').val() == '0') {
                msg += "<li>Vous devez choisir votre produit</li>";
            }

            if (parseInt($('#TxtRevenusTotal').autoNumeric('get')) == 0) {
                msg += "<li>Vous devez indiquer votre/vos révenu (s)</li>";
            }

            if ($('#TxtDate1Versement').val() == '') {
                msg += "<li>Vous devez indiquer la date de premier versement </li>";
            }
             
            if (parseFloat($('#TxtTaux').autoNumeric('get')) == 0){
                msg += "<li>Vous devez indiquer le taux d'intérêt</li>";
            }

            if (parseInt($('#TxtMontant').autoNumeric('get')) == 0) {
                msg += "<li>Vous devez indiquer le montant du prêt</li>";
            }

            if (parseInt($('#TxtDuree').autoNumeric('get')) == 0) {
                msg += "<li>Vous devez indiquer la durée du prêt</li>";
            }

            if (msg.trim() != '') { 
                $.gritter.add({
                    title: 'Validation de formulaire',
                    text: "<ul>" + msg + "</ul>",
                    class_name: 'gritter-error gritter-center gritter-light'
                }); 
            } else {
                if (callBack) {
                    callBack();
                }
            }
             

        };

        $(document).ready(function () {
            add_prospect.InitializePage();
        });
    </script>
</asp:Content>

