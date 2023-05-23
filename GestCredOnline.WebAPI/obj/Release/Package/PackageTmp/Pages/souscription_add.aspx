<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Contenu.master" AutoEventWireup="true" CodeBehind="souscription_add.aspx.cs" Inherits="GestCredOnline.WebAPI.Pages.sousripteur_add" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentHead" runat="server">
    <link type="text/css" href="/Assets/lib/jquery.steps/jquery.steps.css" rel="stylesheet" />
    <style>
        .fontEcriture {
            font-weight: bolder;
            font-size: 15px;
        }

        .wizard > .content {
            min-height: 26em !important;
        }

        i.danger {
            color: red;
        }

        .flex-container {
            display: flex;
            flex-direction: row;
        }

            .flex-container > .flex-item {
                flex: auto;
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
                            <div class="col-md-12">



                                <div id="wizard1">
                                    <section>
                                        <form class="wizard-form fontEcriture" id="basic-forms"
                                            action="#">
                                            <h3>Client </h3>
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

                                                    <div class="col-sm-4">
                                                        <label for="ville"
                                                            class="block">
                                                            Adresse ville <i class="danger">*</i>

                                                        </label>
                                                        <input id="ville" required
                                                            name="ville" type="text"
                                                            class=" form-control">
                                                    </div>
                                                    <div class="col-sm-4">
                                                        <label for="quartier"
                                                            class="block">
                                                            Adresse Quartier <i class="danger">*</i>

                                                        </label>
                                                        <input id="quartier" required
                                                            name="quartier" type="text"
                                                            class=" form-control">
                                                    </div>
                                                    <div class="col-sm-4">
                                                        <label for="lot"
                                                            class="block">
                                                            Adresse Lot <i class="danger">*</i>

                                                        </label>
                                                        <input id="lot" required
                                                            name="lot" type="text"
                                                            class=" form-control">
                                                    </div>

                                                </div>


                                            </fieldset>
                                            <h3>Regime </h3>
                                            <fieldset>
                                                <em class="message_asterisk">Les champs suivis d'un asterisk (*) sont obligatoires</em>
                                                <div class="form-group row">
                                                    <div class="col-sm-12">
                                                        Situation matrimoniale <i class="danger">*</i>
                                                    </div>
                                                    <div class="col-sm-12">
                                                        <select class="situation_matri form-control required" required id="situation_matri" name="situation_matri">
                                                            <option value="">Selectionner
                                                            </option>
                                                            <option value="Celibataire">Celibataire</option>
                                                            <option value="Veuf">Veuf(ve)</option>
                                                            <option value="Divorce">Divorcé(e)</option>
                                                            <option value="Communaute">Marié(e) - Communauté de biens</option>
                                                            <option value="Separation">Marié(e) - Séparation de biens</option>
                                                        </select>
                                                    </div>
                                                </div>
                                                <div class="form-group row frm-conjoint">
                                                    <div class="col-sm-12">
                                                        <label for="nom_conjoint"
                                                            class="block">
                                                            Nom du conjoint 
                                                        </label>
                                                    </div>
                                                    <div class="col-sm-12">
                                                        <input id="nom_conjoint" name="nom_conjoint"
                                                            type="text"
                                                            class="form-control">
                                                    </div>
                                                </div>
                                                <div class="form-group row frm-conjoint">
                                                    <div class="col-sm-12">
                                                        <label for="prenoms_conjoint"
                                                            class="block">
                                                            Prénoms du conjoint 
                                                        </label>
                                                    </div>
                                                    <div class="col-sm-12">
                                                        <input id="prenoms_conjoint"
                                                            name="prenoms_conjoint" type="text"
                                                            class="form-control">
                                                    </div>
                                                </div>
                                                <div class="form-group row frm-conjoint">
                                                    <div class="col-sm-12">
                                                        <label for="telephone_conjoint"
                                                            class="block">
                                                            Téléphone du conjoint  
                                                        </label>
                                                    </div>
                                                    <div class="col-sm-12">
                                                        <input id="telephone_conjoint"
                                                            name="telephone_conjoint" type="text"
                                                            class="form-control phone">
                                                    </div>
                                                </div>
                                                <div class="form-group row frm-conjoint">
                                                    <div class="col-sm-12">
                                                        <label for="adresse_conjoint"
                                                            class="block">
                                                            Adresse du conjoint  
                                                        </label>
                                                    </div>
                                                    <div class="col-sm-12">
                                                        <input id="adresse_conjoint"
                                                            name="adresse_conjoint"
                                                            type="text"
                                                            class="form-control ">
                                                    </div>
                                                </div>
                                                <div class="form-group row">
                                                    <div class="col-sm-12">
                                                        <label for="adresse_conjoint"
                                                            class="block">
                                                            Nombred'enfants à charge  <i class="danger">*</i>
                                                        </label>
                                                    </div>
                                                    <div class="col-sm-12">
                                                        <input id="nbre_enfant"
                                                            name="nbre_enfant"
                                                            type="number"
                                                            class="form-control ">
                                                    </div>
                                                </div>
                                            </fieldset>
                                            <h3>Employeur </h3>
                                            <fieldset>
                                                <em class="message_asterisk">Les champs suivis d'un asterisk (*) sont obligatoires</em>
                                                <div class="form-group row">
                                                    <div class="col-sm-4">
                                                        <label for="raison_social" class="block">Nom / Raison social <i class="danger">*</i>  </label>
                                                        <div class="autocomplete block">
                                                            <input id="raison_social" required placeholder="Saisir la raison sociale"
                                                                name="raison_social" type="text"
                                                                class=" form-control" />
                                                        </div>
                                                        <input id="ChkEntreAgree" hidden name="ChkEntreAgree" type="checkbox">
                                                    </div>

                                                    <div class="col-sm-4">
                                                        <label for="segment" class="block">
                                                            Segment <i class="danger">*</i>
                                                        </label>

                                                        <select id="segment"
                                                            name="segment" required
                                                            class=" form-control">
                                                            <option value="0">Choisir le segment</option>
                                                            <option value="1">TPE</option>
                                                            <option value="2">PME</option>
                                                            <option value="3">Grande entreprise</option>
                                                            <option value="4">Etatique</option>
                                                        </select>

                                                    </div>

                                                    <div class="col-sm-4">
                                                        <label for="date_exercice"
                                                            class="block">
                                                            Durée d'exercice<i class="danger">*</i>
                                                        </label>

                                                        <select id="annee_exercice" required
                                                            name="annee_exercice" class=" form-control">
                                                            <option value="">Choisir la duree </option>
                                                            <option value="17">Moins de 18 mois </option>
                                                            <option value="19">Entre 18 mois et 5 ans </option>
                                                            <option value="61">Entre 5ans et 10 ans </option>
                                                            <option value="121">Entre 10 ans et 20 ans </option>
                                                            <option value="241">Plus de 20 ans </option>
                                                        </select>

                                                    </div>
                                                </div>

                                                <div class=" row">
                                                    <div class="col-sm-4">
                                                        <label for="adresse_postal"
                                                            class="block">
                                                            Téléphone <i class="danger">*</i>
                                                        </label>
                                                        <input id="adresse_telephone" required
                                                            name="adresse_telephone" type="text"
                                                            class=" form-control">
                                                    </div>

                                                    <div class="col-sm-4">
                                                        <label for="adresse_postal"
                                                            class="block">
                                                            Adresse postal <i class="danger">*</i>
                                                        </label>
                                                        <input id="adresse_postal" required
                                                            name="adresse_postal" type="text"
                                                            class=" form-control">
                                                    </div>

                                                    <div class="col-sm-4">
                                                        <label for="adresse_geo"
                                                            class="block">
                                                            Adresse géographique <i class="danger">*</i>
                                                        </label>
                                                        <input id="adresse_geo" required
                                                            name="adresse_geo" type="text"
                                                            class="form-control required">
                                                    </div>
                                                </div>

                                                <br />
                                                <h6 style="color: #064C37; font-weight: bolder;">VOTRE CONTRAT</h6>

                                                <div class="row">

                                                    <div class="col-md-6">
                                                        <label for="matricule" class="block">
                                                            Nature  <i class="danger">*</i>
                                                        </label>

                                                        <div class="flex-container">
                                                            <div class="flex-item ">
                                                                <div class="radio">
                                                                    <label>
                                                                        <input name="chkTypeContrat" id="chkTypeContrat1" type="radio" class="ace">
                                                                        <span class="lbl">CDD (Contrat à durée déterminée)</span>
                                                                    </label>
                                                                </div>
                                                            </div>
                                                            <div class="flex-item ">
                                                                <div class="radio">
                                                                    <label>
                                                                        <input name="chkTypeContrat" id="chkTypeContrat2" type="radio" class="ace">
                                                                        <span class="lbl">CDI  (Contrat à durée indéterminée)</span>
                                                                    </label>
                                                                </div>
                                                            </div>

                                                        </div>


                                                    </div>

                                                    <div class="col-sm-4">
                                                        <div class="flex-container">
                                                            <div class="flex-item">
                                                                <label for="matricule" class="block">
                                                                    Date de début <i class="danger">*</i>
                                                                </label>
                                                                <input id="date_debut"
                                                                    name="date_debut"
                                                                    type="text" required
                                                                    class="form-control date-control">
                                                            </div>
                                                            <div class="flex-item">
                                                                <label for="matricule" class="block">
                                                                    Date de fin prévue <i class="danger">*</i>
                                                                </label>

                                                                <input id="date_fin"
                                                                    name="date_fin"
                                                                    type="text" required
                                                                    class="form-control date-control">
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-sm-2">
                                                        <label for="matricule" class="block">
                                                            Matricule <i class="danger">*</i>
                                                        </label>
                                                        <input id="matricule" required
                                                            name="matricule" type="text" class=" form-control">
                                                    </div>

                                                    <div class="col-sm-6">
                                                        <label for="grade" class="block">
                                                            Grade <i class="danger">*</i>
                                                        </label>

                                                        <select id="grade"
                                                            name="grade" required class=" form-control">
                                                            <option value="0">Chosir le grade</option>
                                                            <option value="1">Assistant</option>
                                                            <option value="2">Agent de maitrise</option>
                                                            <option value="3">Cadre</option>
                                                            <option value="4">Responsable</option>
                                                            <option value="5">Sous directeur</option>
                                                            <option value="6">Directeur</option>
                                                        </select>

                                                    </div>



                                                </div>
                                            </fieldset>
                                            <h3>Fin </h3>
                                            <fieldset>

                                                <div class="row">
                                                    <div class="col-md-12">
                                                        <svg version="1.1" style="width: 100%;" id="interactive-skill" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" width="189px" height="190px" viewBox="0 0 89 90" enable-background="new 0 0 89 90" xml:space="preserve">
                                                            <g id="button_bg" opacity="0" style="opacity: 0;">
                                                                <path fill="#00D9B3" d="M25.7,41.7c-12.4,0-22.6,10.1-22.6,22.6s10.1,22.6,22.6,22.6c12.4,0,22.6-10.1,22.6-22.6
                			S38.2,41.7,25.7,41.7z">
                                                                </path>
                                                            </g><g id="infobutton"><path fill="#00D9B3" d="M25.7,89.9c-14.1,0-25.6-11.5-25.6-25.6c0-14.1,11.5-25.6,25.6-25.6c14.1,0,25.6,11.5,25.6,25.6
                			C51.3,78.4,39.8,89.9,25.7,89.9z M25.7,41.7c-12.4,0-22.6,10.1-22.6,22.6s10.1,22.6,22.6,22.6c12.4,0,22.6-10.1,22.6-22.6
                			S38.2,41.7,25.7,41.7z">
                                                                </path>
                                                                <path fill="#00D9B3" d="M42.5,64.3c0,9.3-7.5,16.8-16.8,16.8C16.4,81.1,9,73.6,9,64.3s7.5-16.8,16.8-16.8
                			C35.1,47.5,42.5,55,42.5,64.3">
                                                                </path>
                                                                <path fill="#00D9B3" d="M25.7,82.6c-10.1,0-18.3-8.2-18.3-18.3C7.5,54.2,15.7,46,25.7,46S44,54.2,44,64.3
                			C44,74.4,35.8,82.6,25.7,82.6z M25.7,49.1c-8.4,0-15.3,6.8-15.3,15.3s6.8,15.3,15.3,15.3S41,72.7,41,64.3
                			C41,55.9,34.1,49.1,25.7,49.1z">
                                                                </path>
                                                                <path fill="#FFFFFF" d="M25.7,74.7c-1.2,0-2.2-1-2.2-2.2V62c0-1.2,1-2.2,2.2-2.2c1.2,0,2.2,1,2.2,2.2v10.4
                			C28,73.7,27,74.7,25.7,74.7z">
                                                                </path>
                                                                <path fill="#FFFFFF" d="M25.7,57.7c-0.6,0-1.2-0.2-1.6-0.7c-0.4-0.4-0.7-1-0.7-1.6c0-0.6,0.2-1.2,0.7-1.6c0.8-0.8,2.3-0.8,3.1,0
                			c0.4,0.4,0.7,1,0.7,1.6c0,0.6-0.2,1.2-0.7,1.6C26.9,57.5,26.3,57.7,25.7,57.7z">
                                                                </path>
                                                            </g><g id="finger" style="transform: matrix(1, 0, 0, 1, 0, 0);"><path fill="#FFFFFF" d="M59,1.6L35.4,25.2c-8.1,8.1-8.1,21.3,0,29.4c8.1,8.1,21.3,8.1,29.4,0l22.5-22.5"></path>
                                                                <path fill="#00D9B3" d="M50.1,62.2c-5.7,0-11.4-2.2-15.8-6.5c-8.7-8.7-8.7-22.8,0-31.5L57.9,0.6C58.5,0,59.5,0,60,0.6
                			c0.6,0.6,0.6,1.5,0,2.1L36.5,26.3C29,33.8,29,46,36.5,53.5s19.8,7.5,27.3,0L86.3,31c0.6-0.6,1.5-0.6,2.1,0c0.6,0.6,0.6,1.5,0,2.1
                			L65.9,55.7C61.6,60,55.8,62.2,50.1,62.2z">
                                                                </path>
                                                                <path fill="#00D9B3" d="M50.2,56.3c-4.4,0-8.5-1.7-11.6-4.8s-4.8-7.2-4.8-11.6s1.7-8.5,4.8-11.6c3.1-3.1,7.2-4.8,11.6-4.8
                			c4.4,0,8.5,1.7,11.6,4.8c6.4,6.4,6.4,16.8,0,23.2C58.7,54.6,54.6,56.3,50.2,56.3z M50.2,26.4c-3.6,0-7,1.4-9.5,3.9
                			s-3.9,5.9-3.9,9.5c0,3.6,1.4,7,3.9,9.5s5.9,3.9,9.5,3.9c3.6,0,7-1.4,9.5-3.9c5.2-5.2,5.2-13.7,0-19C57.1,27.8,53.8,26.4,50.2,26.4z
                			">
                                                                </path>
                                                                <path fill="#00D9B3" d="M78.2,24.1c-0.4,0-0.8-0.1-1.1-0.4L65.9,12.5c-0.6-0.6-0.6-1.5,0-2.1c0.6-0.6,1.5-0.6,2.1,0l11.2,11.2
                			c0.6,0.6,0.6,1.5,0,2.1C78.9,23.9,78.6,24.1,78.2,24.1z">
                                                                </path>
                                                                <path fill="#00D9B3" d="M83.8,18.5c-0.4,0-0.8-0.1-1.1-0.4L71.5,6.9c-0.6-0.6-0.6-1.5,0-2.1c0.6-0.6,1.5-0.6,2.1,0L84.8,16
                			c0.6,0.6,0.6,1.5,0,2.1C84.5,18.4,84.2,18.5,83.8,18.5z">
                                                                </path>
                                                            </g></svg>
                                                    </div>

                                                    <div class="col-md-12">

                                                        <div class="alert alert-block alert-success">
                                                            Vous êtes au terme de votre demande .<br />
                                                            Nous vous invitons à verifier les informations saisies avant de terminer.<br />
                                                            Cliquez sur le boutou "Term".
                                                        </div>
                                                    </div>


                                                </div>



                                            </fieldset>

                                        </form>
                                    </section>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>


            </div>
        </div>
    </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentFoot" runat="server">


    <script type="text/javascript" src="/Assets/lib/jquery.steps/jquery.steps.js"></script>
    <script type="text/javascript" src="/Assets/lib/jquery-validation/jquery.validate.js"></script>

    <script type="text/javascript" src="/Assets/lib/underscore/underscore-min.js"></script>
    <script type="text/javascript" src="/Assets/lib/moment/moment.min.js"></script>
    <script>
        var sClient = null;
        var entrAgree = [];
        var agree = false;
        $(document).ready(function () {

            $("#basic-forms").steps({
                headerTag: "h3",
                bodyTag: "fieldset",
                transitionEffect: "slideLeft",
                autoFocus: true,
                onStepChanging: function (evt, ctIndex, newIndex) {
                    let $form = $(this);
                    return changeForm($form);
                },
                onFinished: function (event, currentIndex) {
                    finishForm();
                },

                onInit: function (event, currentIndex) {
                    initForm();
                }
            });

        });

        function finishForm() {
            updateClient(function () {
                updateRequest(function () {
                    location.href = 'souscription_details.aspx?ID=' + helper.getUrlVars(location.href)["ID"];
                });
            });
        }

        function changeForm($form) {
            if (entrAgree.includes($('#raison_social').val())) { agree = true; } else { agree = false; }
            $form.validate({
                rules: { field: { required: true } },
                errorPlacement: function (error, element) { }
            }).settings.ignore = ":disabled,:hidden";
            return $form.valid();
        }

        function initForm() {
            showClient(function () {
                showEntrepriseAgree(function () {
                    GestCredOnline.autocomplete(document.getElementById("raison_social"), entrAgree);
                    $('#situation_matri').change(function () {
                        let O = $(this).val();
                        pageMatrimonial(O);
                    });
                    appHelper.InitDatePicker(".date-control");
                });
            });
        }

        function pageMatrimonial(O) {
            O = O.trim();
            if (O == 'Celibataire' || O == 'Veuf' || O == 'Divorce') {
                $('.frm-conjoint').hide()
            } else {
                $('.frm-conjoint').show()
            }
        }

        function updateRequest(callback) {
            let o = { DemandeEtat: 9 };
            let id = helper.getUrlVars(location.href)["ID"];
            helper.Odata.patch("Request(" + id + ")", o, "#wizard1", null, null, function () {
                if (callback) {
                    callback();
                }
            });
        }

        function updateClient(callback) {
            let clt = {};
            let situa = appConfig.SituationMatrimoniale.GetSituationByIdentifiant($('#situation_matri').val())
            clt.AddressVille = $('input[name=ville]').val();
            clt.AddressQuartier = $('input[name=quartier]').val();
            clt.AddressLot = $('input[name=lot]').val();
            clt.Nationalite = $('#nationnalite').val();
            clt.ConjointNom = $('input[name=nom_conjoint]').val();
            clt.ConjointPrenom = $('input[name=prenoms_conjoint]').val();
            clt.ConjointDomicil = $('input[name=adresse_conjoint]').val();
            clt.ConjointPhone = $('input[name=telephone_conjoint]').val();
            clt.NbEnfant = parseInt($('input[name=nbre_enfant]').val());
            clt.RegimeMatrimonialID = situa.id;
            clt.EmployeurMatricule = $('input[name=matricule]').val();
            clt.EmployeurCrade = $('#grade').val();
            clt.EmployeurNbAnneeExiste = $('#annee_exercice').val();
            clt.EmployeurEstAgree = agree
            clt.EmployeurSegment = $('#segment').val();
            clt.EmployeurPhone = $('input[name=adresse_telephone]').val();
            clt.EmployeurAdrPost = $('input[name=adresse_postal]').val();
            clt.EmployeurNom = $('input[name=raison_social]').val();
            clt.EmployeurAdrGeo = $('input[name=adresse_geo]').val();
            clt.EmployeurDateFinContrat = new Date(helper.ReturnInternationnalDate($('input[name=date_fin]').val(), 'FR', '/'));
            clt.EmployeurDateEmbauche = new Date(helper.ReturnInternationnalDate($('input[name=date_debut]').val(), 'FR', '/'));
            clt.EmployeurContratID = $('input[name=chkTypeContrat]:checked').attr('id').toString().replace('chkTypeContrat', '').trim();
            helper.Odata.patch("Clients(" + sClient.PersonID + ")", clt, "#wizard1", null, null, function () {
                if (callback) {
                    callback();
                }
            });
        }

        function showClient(callback) {
            let ID = helper.getUrlVars(location.href)["ID"];
            helper.Odata.get("Request(" + ID + ")?$expand=Client,Fichier($expand=ProductProgramCheckList),ProductProgram($expand=ProductProgramCheckList)",
                "#wizard1", "#wizard1", null, null, function (data) {
                    if (data) {
                        let C = data.Client;
                        if (C) {
                            sClient = C;
                            let slect = 'input[id=chkTypeContrat' + C.EmployeurContratID + ']';
                            $(slect).attr('checked', 'checked');
                            $('input[name=nom_client]').val(C.Nom);
                            $('input[name=prenoms_client]').val(C.Prenom);
                            $('input[name=nom_jeune_client]').val(''),
                                $('input[name=ville]').val(C.AddressVille);
                            $('input[name=quartier]').val(C.AddressQuartier);
                            $('input[name=lot]').val(C.AddressLot);
                            $('#annee_exercice').val(C.EmployeurNbAnneeExiste);
                            $('#ChkEntreAgree').prop('checked', C.EmployeurEstAgree);
                            $('input[name=adresse_telephone]').val(C.EmployeurPhone);
                            $('input[name=adresse_postal]').val(C.EmployeurAdrPost);
                            $('input[name=raison_social]').val(C.EmployeurNom);
                            $('input[name=matricule]').val(C.EmployeurMatricule);
                            $('input[name=adresse_geo]').val(C.EmployeurAdrGeo);
                            $('#nationnalite').val(C.Nationalite);
                            $('#grade').val(C.EmployeurCrade);
                            $('#segment').val(C.EmployeurSegment);
                            $('#date_debut').val(helper.ToLocalDateString(C.EmployeurDateEmbauche));
                            $('#date_fin').val(helper.ToLocalDateString(C.EmployeurDateFinContrat));
                            let situa = appConfig.SituationMatrimoniale.GetSituationById(C.RegimeMatrimonialID);
                            $('#situation_matri').val(situa);
                            pageMatrimonial(situa);
                            $('input[name=nom_conjoint]').val(C.ConjointNom);
                            $('input[name=prenoms_conjoint]').val(C.ConjointPrenom);
                            $('input[name=adresse_conjoint]').val(C.ConjointDomicil);
                            $('input[name=telephone_conjoint]').val(C.ConjointPhone);
                            $('input[name=nbre_enfant]').val(C.NbEnfant);
                        }

                        if (callback) {
                            callback()
                        }
                    }


                });
        }

        function showEntrepriseAgree(callback) {
            helper.Odata.get("EntreprisesAgrees?$orderby=RaisonSociale&$select=RaisonSociale",
                "#wizard1", "#wizard1", null, null, function (data) {
                    $.each(data.value, function (i, e) {
                        entrAgree.push(e.RaisonSociale);
                    }) 
                    if (callback) {
                        callback();
                    } 
                });
        }

    </script>
</asp:Content>
