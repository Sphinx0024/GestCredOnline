<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Contenu.master" AutoEventWireup="true" CodeBehind="souscription_details.aspx.cs" Inherits="Activ.BNI.CreditOnline.Pages.souscription_details" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentHead" runat="server">
    <style>
        .tabs-left, .tabs-right {
            min-width: 90px !important;
            vertical-align: top!important;
            width: 0px!important; 
               /* 
                10.108.254.69 bd
                           70 apps 
               */
        }
         
        .nav-tabs {
            border-right: 2px solid #dee2e6 !important;
        }

        .fontEcriture {
            font-weight: bolder;
            font-size: 15px;
        }

        .btnaction{
            margin-top:7px;
        }

        .btn-force-space {
            margin: 1px 3px 1px 1px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentMain" runat="server">
    <div class="page-body" id="DivShowContent">

        <div class="row">
            <div class="col-sm-12">
                <!-- Material tab card start -->
                <div class="card">
                     <div class="alert alert-warning">
                <button class="close" type="button" data-dismiss="alert">
                    <i class="ace-icon fa fa-times"></i>
                </button>
                <strong>Statut </strong> <span id="spanStatusMessage">
                    <lines class="shine"></lines>
                </span>
                <br>
            </div>

                    <div class="card-header">
                        <h2>Détails</h2> 
                    </div>
                    <div class="card-block">

                        <div class="row">
                            <div class="col-lg-12 col-xl-6"  style="border-right: 5px solid #34a839;">
                                <div id="DivDetails"></div>
                                    <button id="BtnEnvoyer" class="btn btnaction btn-white btn-info btn-bold">
                                        <i class="ace-icon fa fa-paper-plane bigger-120 blue"></i>
                                        Envoyer la demande
                                    </button>

                                 <button id="BtnModifier" class="btn btnaction btn-white btn-warning btn-bold">
                                        <i class="ace-icon fa fa-pencil bigger-120 blue"></i>
                                        Modifier la demande
                                    </button>

                                    <button id="BtnAnnuler" class="btn btnaction btn-white btn-danger btn-bold">
                                        <i class="ace-icon fa fa-ban  bigger-120 red"></i>
                                        Annuler la demande
                                    </button>
                            </div>
                          
                            <div class="col-lg-12 col-xl-3" style="border-right: 5px solid #34a839;"> 
                                <div id="DivCommentaire"></div>
                            </div>
                            <div class="col-lg-12 col-xl-3">
                                <div id="DivInformationDocument" class="btn btn-danger"> 
                                     Veuillez nous envoyer la documentation exigée à la soumission de la demande de crédit
                                    <i class="ace-icon fa fa-arrow-down icon-animated-vertical"></i>
                                </div>
                                <div class="sub-title">Documents</div>
                                <div id="DivFileList"></div>
                            </div>

                        </div>
                        <!-- Row end -->
                    </div>
                </div>
                <!-- Material tab card end -->
            </div>
        </div>

    </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentFoot" runat="server">


    <script type="text/javascript">    

        'use strict';
        var show_request = show_request || {};
        show_request.CID = 0;
        show_request.status = 0;

        show_request.InitializePage = function () {
            show_request.CID = helper.getUrlVars(location.href)["ID"];
            show_request.InitControle();
            show_request.show(show_request.CID);
        };

        show_request.InitControle = function () {

            $('#BtnRetour').off().on('click', function () {
                helper.redirection("/apps/dashboard.html", appConfig.divAppContent, function () { });
            });

            $('#BtnEnvoyer').off().on('click', function () {
                appHelper.InitBootBoxConfirm("Vous allez engager la demande. <br/> Un opérateur verifiera votre demande.",
                    function () {
                        var d = {};
                        d.DemandeEtat = appConfig.Status.Engager;
                        helper.Odata.patch("Request(" + show_request.CID + ")", d, "#DivShowContent", null, null, function () {
                            location.reload(true);
                            // show_request.show(show_request.CID);
                        });
                    }, function () { });
            });

            $('#BtnAnnuler').off().on('click', function () {
                appHelper.InitBootBoxConfirm("Vous allez annuler la demande. <br/> voulez vous continuer?",
                    function () {
                        var d = {};
                        d.DemandeEtat = appConfig.Status.Annuler;
                        helper.Odata.patch("Request(" + show_request.CID + ")", d, "#DivShowContent", null, null, function () {
                            location.reload(true);
                            // show_request.show(show_request.CID);
                        });
                    }, function () { });
            });
             
            $('#BtnModifier').off().on('click', function () {
                location.href = "souscription_add.aspx?ID=" + show_request.CID;
            });

            $('.btnaction').hide();

            $('input[id^= uploadFile_]').off();
            $('body').on('change', 'input[id^= uploadFile_]', function () {
                var T = $(this).attr('data-id').toString();
                $(T).removeClass('fa-download').addClass('fa-spinner').addClass('fa-spin');

                show_request.Upload($(this)[0].files, appServiceUrl.odataUrl + '/Files/UploadFile/', function (d) {
                    var _d = {};
                    _d.RequestID = parseInt(show_request.CID);
                    _d.Path = d.msg;
                    _d.SyncStatut = appConfig.StatusSync.adding;
                    _d.CheckListID = parseInt(T.replace("#btnUpload_", ""));

                    helper.Odata.save("Fichier", _d, function (data) {
                        $(T).removeClass('fa-spinner').removeClass('fa-spin').removeClass('btn-warning')
                            .addClass('fa-paperclip').addClass('btn-success');
                        show_request.show(show_request.CID);
                    });

                });
            });
        };

        show_request.statuss = function (status) {
           // show_request.status = status;
            switch (status) {
                case appConfig.Status.EnCours: return 'Votre demande est en cours de validation ';
                case appConfig.Status.Annuler: return 'Vous avez annulé cette demande ';
                case appConfig.Status.EnAttente: $('#BtnAnnuler').show(); return 'Votre demande est attente de soumission';
                case appConfig.Status.Engager: return 'VOTRE DEMANDE A BIEN ETE TRANSMISE A LA BANQUE POUR TRAITEMENT';
                case appConfig.Status.Rejeter: return 'Votre demande a été rejétée ';
                case appConfig.Status.Valider: return 'Votre demande a été validée ';
                default: return status;
            }

        };

        show_request.show = function (ID) {
            helper.Odata.get("Request(" + ID + ")?$expand=Client,Fichier($expand=ProductProgramCheckList),ProductProgram($expand=ProductProgramCheckList)",
                "#DivShowContent", "#DivShowContent", null, null, function (data) {
                    var d = {
                        DateDemande: helper.ToLocalDateString(data.DemandeDate),
                        Product: data.ProductProgram.Libelle,
                        Risque: data.Risque,
                        Reference: data.Reference,
                        Taux: data.CreditTaux.addthousandSepFr(),
                        Montant: data.CreditMontant.addthousandSepFr(),
                        Duree: data.CreditDuree.addthousandSepFr(),
                        CreditMontantEcheance: (data.CreditMontantEcheance != null ? data.CreditMontantEcheance : '0').addthousandSepFr(),
                        Periodicite: appConfig.Periodicite.GetLabelByValue(data.CreditPeriodicite)
                    };
                     
                    show_request.details(d);
                    show_request.commentaires(d);
                    show_request.status = data.DemandeEtat;
                    var T = show_request.statuss(data.DemandeEtat);
                    $('#spanStatusMessage').html(T);
                    show_request.file_list(data.ProductProgram.ProductProgramCheckList, data.Fichier);
                });
        };
         
        show_request.commentaires = function (obj) {
            let d = {
                Eleve: obj.Risque == 'ELEVE' ? true : false,
                Moyen: obj.Risque == 'MOYEN' ? true : false,
                Faible: obj.Risque == 'FAIBLE' ? true : false,
            };

            d.Risque = obj.Risque;
            d.Commentaire = '';
            switch(obj.Risque)
            {
                case 'ELEVE':
                d.Commentaire = "Ce niveau de risque indique que nous vous reclamerons des garantis supplementaires lors du traitemet de votre demande";
                break;
                case 'MOYEN':
                d.Commentaire = "Certaines garantis et informations pourrais être demandées";
                break;
                case 'FAIBLE' :
                d.Commentaire = "Vous semblez remplir toutes les conditions ";
                break;
            }
            var template = $('#TmplShowCommentaires').html();
            var html = Mustache.to_html(template, d);
            $('#DivCommentaire').html(html);
        }
        
        show_request.details = function (obj) {
            var template = $('#TmplShowDetails').html();
            var html = Mustache.to_html(template, obj);
            $('#DivDetails').html(html);
        };

        show_request.file_delete = function (id, callback) {
            helper.Odata.delete("Fichier(" + id + ")",'#DivShowContent', null, null, function () {
                if (callback) {
                    callback();
                }
            });
        };

        show_request.file_list = function (checklist, files) {
            var lst = []; var l_temp = []; var v = false;
            $.each(files, function (i, value) {
                l_temp.push(value.CheckListID);
                var d = {
                    id: value.CheckListID,
                    file_id: value.FileID ? value.FileID : '',
                    title: value.ProductProgramCheckList.Libelle,
                    url: (value.SyncStatut === appConfig.StatusSync.adding ? appServiceUrl.odataUrl + value.Path : value.OnlineUrl)
                };
                lst.push(d);
            });
            $.each(checklist, function (i, value) {
                if (l_temp.indexOf(value.CheckListID) < 0) {
                    v = true;
                    var d = {
                        id: value.CheckListID, 
                        title: value.Libelle,
                        url: false,
                        new: (show_request.status == 4 ? false : true)
                    };
                    lst.push(d);
                }
            });

            if (v === false && show_request.status === appConfig.Status.EnAttente) {
                $('#BtnEnvoyer').show();
                $('#BtnModifier').show();
                $('#DivInformationDocument'). hide();

            } else {
                $('#DivInformationDocument').show();
                $('#BtnEnvoyer').hide();
                $('#BtnModifier').hide();
            }
            if (show_request.status == 4) {
                $('#DivInformationDocument').hide();
            }


            var template = $('#TmplFiles').html();
            var obj = {};
            obj.depts = lst;
            var html = Mustache.to_html(template, obj);
            $('#DivFileList').html(html);
            $('[data-rel="tooltip"]').tooltip();
            $('.fp').on('click', function () {
                var t = $(this).attr('data-file').toString();
                $(t).click();
            });

            $('[id^="btnDeleteUpload_"]').on('click', function () {
                let $that = $(this); 
                let fid = $that.attr('data-fileid').toString();
                let title = $that.attr('data-filetitle').toString();
                let msgbox = `Vous êtes sur le point de supprimer le document : <br> <b>${title}</b> <br> Voulez-vous continuer ?`;


              let dgl =  bootbox.dialog({
                    title: 'Suppression de fichier',
                    message: msgbox,
                  size: 'small',
                    onEscape: true,
                    backdrop: true,
                    buttons: {
                        Oui: {
                            label: 'Oui',
                            className: 'btn-primary btn-force-space',
                            callback: function () {
                                show_request.file_delete(fid,  function () {
                                    show_request.show(show_request.CID);
                                });
                            }
                        },
                        Non: {
                            label: 'Non',
                            className: 'btn-danger btn-force-space',
                            callback: function () {
                                dgl.modal('hide');
                            }
                        },
                        
                    }
                })

                dgl.init(function () {

                    let x = $('.bootbox-close-button').clone();
                    $('.bootbox-close-button').remove();
                    $('.modal-title').after(x);
                });
                 
            });

        };
         
        show_request.Upload = function (TargetFile, Url, CallBack) {
            var countertemp = 1;
            function UploadFileChunk(Chunk, FileName, TotalParts, CallBack) {
                var FD = new FormData();
                FD.append('file', Chunk, FileName);
                return $.ajax({
                    type: "POST",
                    url: appServiceUrl.odataUrl + '/Files/UploadFile/',
                    contentType: false,
                    processData: false,
                    //jsonp: "callback",
                    data: FD,
                    success: function (d) {
                        countertemp++;
                        //console.log(TotalParts, countertemp )
                        if (TotalParts == (countertemp -1)) {
                            if (CallBack !== null) {
                                CallBack(d);
                            }
                        }
                    }
                });
            }

            function UploadFile(TargetFile, Url, CallBack) {
                // create array to store the buffer chunks
                var FileChunk = [];
                // the file object itself that we will work with
                var file = TargetFile[0];
                // set up other initial vars
                var MaxFileSizeMB = 1;
                var BufferChunkSize = MaxFileSizeMB * (1024 * 1024);
                var ReadBuffer_Size = 1024;
                var FileStreamPos = 0;
                // set the initial chunk length
                var EndPos = BufferChunkSize;
                var Size = file.size;

                // add to the FileChunk array until we get to the end of the file
                while (FileStreamPos < Size) {
                    // "slice" the file from the starting position/offset, to  the required length
                    FileChunk.push(file.slice(FileStreamPos, EndPos));
                    FileStreamPos = EndPos; // jump by the amount read
                    EndPos = FileStreamPos + BufferChunkSize; // set next chunk length
                }
                // get total number of "files" we will be sending
                var TotalParts = FileChunk.length;
                var PartCount = 0;
                // loop through, pulling the first item from the array each time and sending it 
                 
                var chunk;
                var Pagers = [];
                while (chunk = FileChunk.shift()) {
                    PartCount++;
                    // file name convention
                    var FilePartName = file.name + ".part_" + PartCount + "." + TotalParts;
                    // send the file
                    UploadFileChunk(chunk, FilePartName, TotalParts, CallBack);
                }
                 
            }

            UploadFile(TargetFile, Url, CallBack);

        };

        $(document).ready(function () {
            show_request.InitializePage();
        });

    </script>

    <script id="TmplShowDetails" type="text/template">


          <div class="sub-title font-weight-bold">Contract</div>
                                <div class="row">

                                     <div class="col-sm-6">
                                        <p class="m-b-10 f-w-900">Reference</p>
                                        <h6 class="text-muted f-w-400">  {{Reference}}
                                        </h6>
                                    </div>

                                    <div class="col-sm-6">
                                        <p class="m-b-10 f-w-900">Produit</p>
                                        <h6 class="text-muted f-w-400">  {{Product}}
                                        </h6>
                                    </div>
                                  
                                </div>
                                <div class="row">
                                    <div class="col-sm-6">
                                        <p class="m-b-10 f-w-900">Montant en chiffre</p>
                                        <h6 class="text-muted f-w-400"> {{Montant}}
                                        </h6>
                                    </div>
                                    <div class="col-sm-3">
                                        <p class="m-b-10 f-w-900">Taux(%)</p>
                                        <h6 class="text-muted f-w-400">  {{Taux}}
                                        </h6>
                                    </div>
                                    <div class="col-sm-3">
                                        <p class="m-b-10 f-w-900"></p>
                                        <h6 class="text-muted f-w-400">
                                        </h6>
                                    </div>
                                </div>
                               
                                <div class="row">
                                    <div class="col-sm-6">
                                        <p class="m-b-10 f-w-900">Duré du prêt</p>
                                        <h6 class="text-muted f-w-400"> {{Duree}} Mois
                                        </h6>
                                    </div>
                                    <div class="col-sm-6">
                                        <p class="m-b-10 f-w-900">Périodicité</p>
                                        <h6 class="text-muted f-w-400">  {{Periodicite}}
                                        </h6>
                                    </div>
                                   
                                </div>
                                <div class="row">
                                    <div class="col-sm-12">
                                        <p class="m-b-10 f-w-900">Montant par échéance</p>
                                        <h6 class="text-muted f-w-400">  {{CreditMontantEcheance}}
                                        </h6>
                                    </div>
                                    
                                   
                                </div>
                   
</script>

    <script id="TmplShowCommentaires" type="text/template"> 

        <div>   
            {{#Eleve}}
            <div style="width:20px; height:30px; background-color:forestgreen ; display:inline-block"></div>
             <div style="width:20px; height:50px; background-color:orange; display:inline-block"></div>
             <div style="width:20px; height:70px; background-color:darkred; display:inline-block"></div>
             {{/Eleve}}
             {{#Moyen}}
             <div style="width:20px; height:30px; background-color:forestgreen ; display:inline-block"></div>
             <div style="width:20px; height:50px; background-color:orange; display:inline-block"></div> 
             {{/Moyen}}
             {{#Faible}}
              <div style="width:20px; height:30px; background-color:forestgreen ; display:inline-block"></div> 
             {{/Faible}}
        </div>
        <div>
            Niveau de risque : <b>{{Risque}}</b>
        </div>
        <br />
        {{Commentaire}}


    </script>

    <script id="TmplShowClients" type="text/template">    

          <div  class="row" style="margin-right: -100%;">
                                            <div class="col-sm-3">
                                                <p class="m-b-10 f-w-900 fontEcriture">Nom</p>
                                                <h6 class="text-muted f-w-400">{{Nom}}
                                                </h6>
                                            </div>
                                            <div class="col-sm-9">
                                                <p class="m-b-10 f-w-900 fontEcriture">Prenoms</p>
                                                <h6 class="text-muted f-w-400">{{Prenoms}}
                                                </h6>
                                            </div>
                                        </div>
                                        <br />
                                        <div  class="row">
                                            
                                            <div class="col-sm-6">
                                                <p class="m-b-10 f-w-900 fontEcriture">Sexe</p>
                                                <h6 class="text-muted f-w-400">{{Sexe}}
                                                </h6>
                                            </div>
                                        </div>
                                          <br />
                                        <div  class="row" style="margin-right: -1%!important;" >
                                            
                                            <div class="col-sm-6">
                                                <p class="m-b-10 f-w-900 fontEcriture">Date naissance</p>
                                                <h6 class="text-muted f-w-400">{{DateNaissance}}
                                                </h6>
                                            </div>
                                            <div class="col-sm-6"> 
                                                <p class="m-b-10 f-w-900 fontEcriture">Lieu naissance</p>
                                                <h6 class="text-muted f-w-400">{{LieuNaissance}}
                                                </h6>
                                            </div>
                                            <div class="col-sm-6"> 
                                                <p class="m-b-10 f-w-900 fontEcriture">Nationnalité</p>
                                                <h6 class="text-muted f-w-400">{{Nationnalite}}
                                                </h6>
                                            </div>

                                        </div>
                                        <div class="row">
                                            
                                            <div class="col-sm-6"> 
                                                <p class="m-b-10 f-w-900 fontEcriture">Nombre d'enfant(s)</p>
                                                <h6 class="text-muted f-w-400">{{NbEnfants}}
                                                </h6>
                                            </div>
                                        </div>
                                          <br />
                                        <div  class="row" >
                                            <div class="col-sm-4">
                                                <p class="m-b-10 f-w-900 fontEcriture">Nature pièce</p>
                                                <h6 class="text-muted f-w-400">YAM
                                                </h6>
                                            </div>
                                            <div class="col-sm-8">
                                                <p class="m-b-10 f-w-900 fontEcriture">Référence piéce </p>
                                                <h6 class="text-muted f-w-400">TIEMOKO QOUDDOUSS
                                                </h6>
                                            </div>
                                        </div>
                                        
                                        <div  class="row" >
                                            <div class="col-sm-6">
                                                <p class="m-b-10 f-w-900 fontEcriture">Téléphone mobile</p>
                                                <h6 class="text-muted f-w-400">0000000000
                                                </h6>
                                            </div>
                                            <div class="col-sm-6">
                                                <p class="m-b-10 f-w-900 fontEcriture">Téléphone  Bureau </p>
                                                <h6 class="text-muted f-w-400">0000000000
                                                </h6>
                                            </div>
                                            <div class="col-sm-6">
                                                <p class="m-b-10 f-w-900 fontEcriture">Téléphone Domicile</p>
                                                <h6 class="text-muted f-w-400">0000000000
                                                </h6>
                                            </div>
                                        </div>
                                        <br />
                                        <div  class="row" >
                                            <div class="col-sm-6">
                                                <p class="m-b-10 f-w-900 fontEcriture">Date d'établissement</p>
                                                <h6 class="text-muted f-w-400">01-01-2021
                                                </h6>
                                            </div>
                                            <div class="col-sm-6">
                                                <p class="m-b-10 f-w-900 fontEcriture">Date d'expiration </p>
                                                <h6 class="text-muted f-w-400">06-09-2029
                                                </h6>
                                            </div>
                                            
                                        </div>
                                        <div  class="row" >
                                            <div class="col-sm-4">
                                                <p class="m-b-10 f-w-900 fontEcriture">Ville</p>
                                                <h6 class="text-muted f-w-400">01-01-2021
                                                </h6>
                                            </div>
                                            <div class="col-sm-4">
                                                <p class="m-b-10 f-w-900 fontEcriture">Quartier </p>
                                                <h6 class="text-muted f-w-400">06-09-2029
                                                </h6>
                                            </div>
                                            <div class="col-sm-4">
                                                <p class="m-b-10 f-w-900 fontEcriture">Lot </p>
                                                <h6 class="text-muted f-w-400">06-09-2029
                                                </h6>
                                            </div>

    </script>
     
    <script id="TmplFiles" type="text/template">
        {{#depts}}
        <div class="profile-activity clearfix" style="border-bottom:2px solid #ff6a00">
            <div> 
                {{#url}}
                <a href="#" title=" Supprimer  le fichier " data-rel="tooltip" class="pull-right" > 
                  <i  class=" thumbicon fa fa-times btn-danger no-hover" id="btnDeleteUpload_{{id}}" style="cursor:pointer;" data-filetitle="{{title}}" data-fileid="{{file_id}}"></i> 
                    </a>
                 <a title="Consulter le fichier " data-rel="tooltip" href="{{url}}" class="pull-right" target="_blank">
                     <i class="  thumbicon fa fa-paperclip  fp btn-success no-hover" style="cursor:pointer;"></i>
                 </a>
                {{/url}}

                {{#new}}
                <i title="Joindre un fichier " data-rel="tooltip" class="pull-right thumbicon fa  fa-download  fp btn-warning no-hover" id="btnUpload_{{id}}" style="cursor:pointer;" data-file="#uploadFile_{{id}}"></i>
                <input type="file" id="uploadFile_{{id}}" data-id="#btnUpload_{{id}}" name="file" style="display:none" />
                {{/new}}
                 {{title}}
            </div>
        </div>
        {{/depts}}
    </script>

</asp:Content>
