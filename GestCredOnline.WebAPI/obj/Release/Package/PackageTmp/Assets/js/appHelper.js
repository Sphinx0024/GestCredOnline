var appHelper = appHelper || {};

$.fn.extend({
    animateCss: function (animationName, callBack) {
        var animationEnd = 'webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend';
        this.addClass('animated ' + animationName).addClass("popupPanel_black").one(animationEnd, function () {
            $(this).removeClass('animated ' + animationName);
            if (callBack) {
                callBack.call();
            }
        });
        return this;
    }
});

 
appHelper.InitBootBoxConfirm = function (msg, okCallBack, noCallBack) {
    var d = bootbox.confirm({
        message: msg,
        buttons: {
            confirm: {
                label: 'Continuer',
                className: 'btn-success'
            },
            cancel: {
                label: 'Annuler',
                className: 'btn-danger'
            }
        },
        callback: function (result) {
            if (result) {
                if (okCallBack !== null) {
                    okCallBack();
                }
            } else {
                if (noCallBack !== null) {
                    noCallBack();
                }
            }
        }
    });
    d.init(function () {
        $('.modal-backdrop.in').css('z-index', '2');
    });
};

//appHelper.GetConnectedInfo = function () {
//    var obj = {};
//    obj.ID = localStorage[appConfig.profileName] ? localStorage[appConfig.profileName].toString() : null;
//    obj.FullName = localStorage[appConfig.profileName] ? localStorage[appConfig.profileName].toString() : null;
//    obj.Organisation = localStorage[appConfig.connectOrg] ? localStorage[appConfig.connectOrg].toString() : null;
//    obj.Profile = localStorage[appConfig.connectConnected] ? localStorage[appConfig.connectConnected].toString() : null;
//    obj.OrganisationEntity = localStorage[appConfig.connectEnt] ? localStorage[appConfig.connectEnt].toString() : null;
//    obj.Direction = localStorage[appConfig.DirectionID] ? localStorage[appConfig.DirectionID].toString() : null;
//    obj.Department = localStorage[appConfig.DepartementID] ? localStorage[appConfig.DepartementID].toString() : null;
//    obj.Service = localStorage[appConfig.ServiceID] ? localStorage[appConfig.ServiceID].toString() : null;
//    obj.ProCategory = localStorage[appConfig.EmpCategory] ? localStorage[appConfig.EmpCategory].toString() : null;
//    obj.MyGroup = localStorage[appConfig.groupSouscrit] ? localStorage[appConfig.groupSouscrit].toString() : null;
//    obj.Agence = localStorage[appConfig.AgenceID] ? localStorage[appConfig.AgenceID].toString() : null;
//    return obj;
//};

appHelper.InitControle = function () { 
    try { $('[data-rel=tooltip]').tooltip(); } catch (e) { console.error(e); }
     
    appHelper.InitSlider('.slider-priorite');
    appHelper.InitDatePicker(".datepicker");
    appHelper.InitChoosen ('.chosen-select');
    appHelper.InitControleDataTable('.datatable');
    appHelper.InitCkeditor('.ckeditor');
    appHelper.InitAutoNumeric(".autoNumeric");
};

appHelper.InitSlider = function (selector) {

    try {
        $(selector).css('width', '200px').slider({
            value: 1,
            range: "min",
            min: 1,
            max: 5,
            step: 1,
            slide: function (event, ui) {
                var val = parseInt(ui.value);
                $('#DivPriorite').html('Niveau ' + val).attr('data-priority', val);
            }
        });
    } catch (e) { console.error(e); }
};

appHelper.InitDatePicker = function (selector) {


    try {
        $(selector).datepicker({
            showOtherMonths: true,
            selectOtherMonths: true,
            dateFormat: "dd/mm/yy",
            //isRTL:true,
            changeMonth: true,
            changeYear: true,
            yearRange: '1900:2150',
            showButtonPanel: true
            /*  beforeShow: function() {
                 //change button colors
                 var datepicker = $(this).datepicker( "widget" );
                 setTimeout(function(){
                     var buttons = datepicker.find('.ui-datepicker-buttonpane')
                     .find('button');
                     buttons.eq(0).addClass('btn btn-xs');
                     buttons.eq(1).addClass('btn btn-xs btn-success');
                     buttons.wrapInner('<span class="bigger-110" />');
                 }, 0);
               }
           */
        });
    } catch (e) { console.error(e); }

};

appHelper.InitChoosen = function (selector) {
    try {
        $(selector).chosen();
        //resize the chosen on window resize
        $(window)
            .off('resize.chosen')
            .on('resize.chosen', function () {
                $('.chosen-select').each(function () {
                    var $this = $(this);
                    $this.next().css({ 'width': $this.parent().width() });
                });
            }).trigger('resize.chosen');
        //resize chosen on sidebar collapse/expand
        $(document).on('settings.ace.chosen', function (e, event_name, event_val) {
            if (event_name !== 'sidebar_collapsed') return;
            $('.chosen-select').each(function () {
                var $this = $(this);
                $this.next().css({ 'width': $this.parent().width() });
            });
        });
    } catch (e) { console.error(e); }

};

appHelper.InitAutoNumeric = function (selector) {
    try {
        $.extend($.fn.autoNumeric.defaults, {
            digitGroupSeparator: ' ',
            decimalCharacter: ','
        }); 
        $(selector).autoNumeric('init');
    } catch (e) {
        console.error(e);
    }
};

appHelper.InitCkeditor = function (selector) {
    try { $(selector).ckeditor(); } catch (e) { console.error(e); }
};

appHelper.InitControleDataTable = function (selector) {
    try {
        $(selector).DataTable({
            "order": [[1, "asc"]],
            "pagingType": "numbers",
            "oLanguage": {
                "sLengthMenu": "Afficher _MENU_ éléments par page",
                "sZeroRecords": "Il n'y a aucun élément à afficher ",
                "sInfo": "Affichage de _START_ à _END_ sur _TOTAL_ éléments",
                "sInfoEmpty": " ",
                "sSearch": "Recherche",
                "sInfoFiltered": "(filtre de  _MAX_ éléments)"
            }
        });
    } catch (e) { console.error(e); }
};

appHelper.InitControleStable = function () {
    appHelper.InitCkeditor('.ckeditor');

    appHelper.InitDatePicker(".datepicker");

    appHelper.InitSlider('.slider-priorite');

    appHelper.InitChoosen('.chosen-select');

    try { $('[data-rel=tooltip]').tooltip(); } catch (e) { console.error(e); }
     
};
 
appHelper.BtnLoader = function (btnId, isRemoved) {
    btnSelector = $("#" + btnId);
    if (!isRemoved) {
        btnSelector.find(".fa").hide();
        $("<i aria-hidden='true' class='fa fa-spinner fa-pulse'></i>").insertAfter(btnSelector.find(".fa"));
        btnSelector.addClass("is-disabled");
    }
    else {
        btnSelector.find(".fa-spinner").remove();
        //$("<i aria-hidden='true' class='fa fa-spinner fa-pulse'></i>").insertAfter(btnSelector.find(".fa"));
        btnSelector.find(".fa").show();
        btnSelector.removeClass("is-disabled");
    }
};

appHelper.GetFileIcon = function (fileName) {
    var classe = "";
    var tFileName = fileName.split(".");
    switch (tFileName[tFileName.length - 1].toLowerCase()) {
        case "docx":
        case "doc":
        case "docm":
        case "dot":
        case "dotm":
            classe = "fa-file-word-o";
            break;
        case "csv":
        case "xls":
        case "xlsx":
            classe = "fa-file-excel-o";
            break;
        case "ppt":
        case "pptx":
        case "pptm":
            classe = "fa-file-powerpoint-o";
            break;
        case "pdf":
            classe = "fa-file-pdf-o";
            break;
        case "png":
        case "gif":
        case "jpg":
        case "jpeg":
            classe = "fa-file-image-o";
            break;
        default:
            classe = "fa-file-o";
            break;
    }
    return classe;
};

appHelper.openZLPopupWithCallBack = function (content, url, animation, width, height, title, callBack) {
    appHelper.openZLPopup(content, url, animation, width, height, title);

    if (callBack) {
        callBack.call();
    }
};

appHelper.openZLPopup = function (content, url, animation, width, height, title) {
    var popupTemplate = '<div class="popupPanel_cover">' +
        '<div class="popupPanel panelPopupShadow">' +
        '<div class="_cx_l1 _cx_o1 ms-bg-color-white" style="position: absolute;" >' +
        '<div style="position: absolute; top: 0px; right: 0px; bottom: auto; left: 0px; height: 40px; width: auto;">' +
        '<div class="ms-bg-color-themeLighterTitle">' +
        '<div class="zlPopupTitle"><i class="fa fa-list" style="color:white" aria-hidden="true">&nbsp;</i><span class="SpanPopupTitle"></span></div>' +
        '<div class="_fce_c" role="presentation" style="display: inline;">' +
        '<div class="_fce_e _fce_g">' +
        '<button autoid="_fce_0 " type="button" class="_fce_i ms-fwt-r ms-fcl-np o365button close-Popup">' +
        '<span class="image owaimg _fce_p ms-icon-font-size-16 ms-fcl-ns-b">' +
        '<i class="fa fa-times" style="color:white" aria-hidden="true"></i>' +
        '</span>' +
        '<span class="o365buttonLabel _fce_r _fce_n" style="display: none;"></span>' +
        '</button>' +
        '</div>' +
        '</div>' +
        '</div>' +
        '<div class="_cx_f2" >' +
        '<div class="_fce_a ms-bg-color-themeLighterAlt" >' +
        '<div id="zlPopupHeader" class="_fce_b zlPopupHeader" style="margin-left: 0px; margin-right: 0px;">' +
        '</div>' +
        '</div>' +
        '</div>' +
        '</div>' +
        '<div id="zlPopupContent" class="_cx_n1 zlPopupContent customScrollBar">' +
        '</div>' +
        '</div>' +
        '</div>' +
        '</div>';

    var popupId = "popupPanel_" + new Date().getTime();
    var selector = "#" + popupId;
    //appHelper.closeZlPopup();

    switch (width) {
        case "lg":
            width = "zl_lg";
            break;

        case "sm":
            width = "zl_sm";
            break;

        case "md":
            width = "zl_md";
            break;

        case "full":
            width = "zl_full";
            break;

        default:
            width = "zl_lg";
            break;
    }

    var zlPopup = $(popupTemplate);

    zlPopup.children(".popupPanel").attr("id", popupId);

    ////if (!height) {
    ////};

    if (!animation) {
        animation = "fadeInRight";
    }

    if (!title) {
        title = "Popup Title here";
    }

    zlPopup.find(".SpanPopupTitle").text(title);

    if (url) {
        zlPopup
            .animateCss(animation,
                function () {
                    $(".close-Popup").on("click",
                        function () {
                            appHelper.closeZlPopup(selector);
                            //$(".popupPanel_cover").hide().remove();
                        });

                    helper.redirection(url, $(selector).find(".zlPopupContent"), function () {
                        //alert("ok callback");
                        var lastPopup = appHelper.getLastZlPopup();
                        lastPopup.find(".zlPopupHeader_button").contents().appendTo(lastPopup.find(".zlPopupHeader"));
                    });
                    //helper.ChargerPageGETAvecLoader(url,
                    //    $(selector).find(".zlPopupContent"),
                    //    $(selector).find(".zlPopupContent"),
                    //    null,
                    //    null,
                    //    function () {
                    //        var lastPopup = appHelper.getLastZlPopup();
                    //        lastPopup.find(".zlPopupHeader_button").contents().appendTo(lastPopup.find(".zlPopupHeader"));
                    //    });
                })
            .find(".popupPanel")
            .addClass(width);
        //.appendTo('body')
        //.show();
        zlPopup.appendTo('body').show();
    }
    else {
        // $(selector).children().find
        $("#zlPopupContent").html(content);
        zlPopup.animateCss(animation).find(".popupPanel").addClass(width);
        zlPopup.appendTo('body').show();
        $(".close-Popup").on("click", function () {
            appHelper.closeZlPopup(selector);
            //$(".popupPanel_cover").hide().remove();
        });
    }
};

appHelper.closeZlPopup = function (selector) {
    if (selector) {
        $(selector).parent(".popupPanel_cover").hide().remove();
    }
    else {
        $(".popupPanel_cover").hide().remove();
    }
};

appHelper.getLastZlPopup = function () {
    var time = 0;

    $(".popupPanel_cover").each(function (index) {
        var newTime = parseInt($(this).children(".popupPanel").attr("id").replace("popupPanel_", ""));
        //console.log($(this).children(".popupPanel").attr("id").replace("popupPanel_"));
        if (newTime > time) {
            time = newTime;
        }
    });

    return $("#popupPanel_" + time);
};

appHelper.HtmlRender = function (url, template, tReplacer, callBack) {
    if (url) {
        $.ajax({
            type: "GET",
            data: "",
            url: appFolder.appUrl + url,
            cache: false,
            success: function (msg) {
                Render(msg);
            },
            error: function (msg) {
                //Render(msg.responseText);
            },
            complete: function () {
            }
        });
    }
    else {
        Render(template);
    }

    function Render(tempHtml) {
        var htmlRetour = "";
        var htmlTemp = "";
        for (var i = 0; i < tReplacer.length; i++) {
            htmlTemp = tempHtml;
            for (var j = 0; j < tReplacer[i].length; j++) {
                htmlTemp = htmlTemp
                    .toString()
                    .replaceAll(tReplacer[i][j].key, tReplacer[i][j].value);
            }
            htmlRetour += htmlTemp;
        }

        callBack(htmlRetour);
    }
};

appHelper.replaceTemplateData = function (template, replacer) {
    if (template.indexOf("##NOM##") >= 0) {
        template = template.replaceAll("##NOM##", replacer ? replacer.InfoPersonnel.Nom : "");
    }

    if (template.indexOf("##PRENOM##") >= 0) {
        template = template.replaceAll("##PRENOM##", replacer ? replacer.InfoPersonnel.Prenom : "");
    }

    if (template.indexOf("##EMAIL##") >= 0) {
        template = template.replaceAll("##EMAIL##", replacer ? replacer.InfoPersonnel.Email : "");
    }

    if (template.indexOf("##PHONE##") >= 0) {
        template = template.replaceAll("##PHONE##", replacer ? replacer.InfoPersonnel.Phone : "");
    }

    if (template.indexOf("##MATRICULE##") >= 0) {
        template = template.replaceAll("##MATRICULE##", replacer ? replacer.Matricule : "");
    }

    return template;
};

appHelper.InitializeLadda = function (selector) {
    Ladda.bind(selector);
    //var l = $(selector).ladda();
};

appHelper.StopLadda = function (selector) {
    Ladda.bind(selector);
    //var l = $(selector).ladda();
};

appHelper.InitializePersonPicker = function (selector, url, render, Ttooltip, callback) {
    var searchRequest = null;
    var cache = {};
    var personDataSource = null;
    $(selector).attr("placeholder", "Nom, Prenom, Email, Fonction ...");
    $(selector)
        .tokenfield({
            autocomplete: {
                //source: appServiceUrl.trombiUrl + "GetByID/" + localStorage.getItem("PROFILE_OWNERORGID"),
                source: function (request, response) {
                    //console.log("oui");
                    var term = request.term;

                    if (!personDataSource) {
                        personDataSource = [];
                    }

                    if (searchRequest) {
                        searchRequest.abort();
                        $(selector).parent(".tokenfield").removeClass("ui-autocomplete-loading");
                    }

                    if (term in cache) {
                        response(cache[term]);
                        $(selector).parent(".tokenfield").removeClass("ui-autocomplete-loading");
                        return;
                    }

                    $(selector).parent(".tokenfield").addClass("ui-autocomplete-loading");

                    searchRequest = $.getJSON(url + "/" + term,
                        function (data) {
                            searchRequest = null;
                            personDataSource = render ? render(data) : defaultRender(data),
                                cache[term] = personDataSource;
                            response(personDataSource);
                            // console.log(personDataSource);
                        })
                        .complete(function () {
                            $(selector).parent(".tokenfield").removeClass("ui-autocomplete-loading");
                        });
                },
                delay: 100,
                minLength: 3,
                create: function (event, ui) {
                    $(this).data('ui-autocomplete')._renderItem = function (ul, item) {
                        return $("<li class='personPickerLi' style='border-left:10px solid " + classTypePerson(item.type) + " !important'>")
                            .append("<div>" + item.label + "<br><small>" + item.desc + "</small></div>")
                            .appendTo(ul);
                    };
                }
            },
            showAutocompleteOnFocus: true,
            allowPasting: false
        })
        .on('tokenfield:createtoken',
            function (event) {
                //check if element is from my data source

                if (personDataSource) {
                    var exists = false;
                    var availableTokens = personDataSource;
                    $.each(availableTokens,
                        function (index, token) {
                            if (event.attrs.value === token.value) {
                                exists = true;
                            }
                        });

                    if (!exists) {
                        event.preventDefault();
                        //prevents creation of token
                    }
                }

                //check if token already exist
                var existingTokens = $(this).tokenfield('getTokens');
                $.each(existingTokens,
                    function (index, token) {
                        if ((token.value === event.attrs.value) && (token.type === event.attrs.type))
                            event.preventDefault();
                    });

                //alert(event.attrs.label);
                if (parseInt(event.attrs.label))
                    event.preventDefault();

                if (callback) {
                    callback.call();
                }
            })
        .on('tokenfield:createdtoken',
            function (e) {
                //check if element is from my data source
                //console.log(personDataSource);

                if (personDataSource) {
                    var exists = false;

                    var availableTokens = personDataSource;

                    $.each(availableTokens,
                        function (index, token) {
                            if (e.attrs.value === token.value) {
                                exists = true;
                            }
                        });

                    if (exists) {
                        //console.log(e.relatedTarget);
                        //$(e.relatedTarget).addClass('invalid')
                        if (Ttooltip) {
                            if (Ttooltip.length > 0) {
                                var tooltipTarget = "tooltip_content_" + e.attrs.value + "_" + e.attrs.type;
                                var tooltipClass = "tooltip_person_picker_" + e.attrs.value + "_" + e.attrs.type;

                                if ($(".tooltip_templates").length === 0) {
                                    $("body").append('<div class="tooltip_templates"></div>')
                                }

                                $(e.relatedTarget)
                                    .addClass(tooltipClass)
                                    .attr("data-tooltip-content", "#" + tooltipTarget);

                                $(".tooltip_templates").append(contextMenuRender(e, tooltipTarget))

                                //$(".tooltip_person_picker").tooltipster('destroy');

                                $("." + tooltipClass).tooltipster({
                                    animation: 'fade',
                                    contentAsHTML: true,
                                    theme: 'tooltipster-punk',
                                    trigger: 'click',
                                    interactive: true
                                });
                            }
                        }
                        //e.preventDefault();
                        //prevents creation of token
                    }
                }
            })
        .on('tokenfield:edittoken', function (e) {
            e.preventDefault();
        });

    function defaultRender(data) {
        return $.map(data,
            function (item) {
                return {
                    value: (item ? item.Value : ""),
                    label: (item ? item.Label : ""),
                    desc: (item ? item.Desc : ""),
                    type: (item ? item.Type : "")
                };
            });
    }

    function classTypePerson(type) {
        var classe = "";
        switch (type) {
            case appConfig.TYPE_CONTACT:
                classe = "red";
                break;

            case appConfig.TYPE_USER:
                classe = "yellow";
                break;

            case appConfig.TYPE_EMPLOYEE:
                classe = "green";
                break;

            case appConfig.TYPE_TEAM:
                classe = "blue";
                break;

            default:
                classe = "green";
                break;
        }

        return classe;
    }

    function contextMenuRender(e, tooltipTarget) {
        var html = '<p class="person_context_link"  id="' + tooltipTarget + '" >';
        for (var i = 0; i < Ttooltip.length; i++) {
            if (Ttooltip[i].function) {
                html += '<a  href="#" onclick="' + Ttooltip[i].function + '" data-id="' + e.attrs.value + '" class="badge badge-grey ' + Ttooltip[i].class + '"><i class="fa ' + Ttooltip[i].icon + '" aria-hidden="true"></i></a>&nbsp;';
            } else {
                html += '<a  href="#"  data-url="' + Ttooltip[i].url + '" data-id="' + e.attrs.value + '" class="badge badge-grey ' + Ttooltip[i].class + '"><i class="fa ' + Ttooltip[i].icon + '" aria-hidden="true"></i></a>&nbsp;';
            }
            //var target = T[i].function;

            //$("body").on("click", "." + Ttooltip[i].class, function () {
            //    Ttooltip[i].function();
            //});
        }
        html += '</p>';

        return html;
    }
};

appHelper.formData = function (i, files) {
    ////var fileInput = $("input[name=avatar]");
    ////var fileInput = document.getElementsByName(selector)[i];

    var file = files[i];

    //console.log(file.name);

    var formData = new FormData();

    formData.append('file', file);

    return formData;
};

appHelper.FormatFileSize = function (size) {
    var fileMesure = "Mo";

    var formatSize = Math.round((size / 1000000) * 100) / 100;

    if (formatSize < 1) {
        fileMesure = "Ko";
        formatSize = Math.round((size / 1000) * 100) / 100;
    }

    if (formatSize > 1000) {
        fileMesure = "Go";
        formatSize = Math.round((size / 1000000000) * 100) / 100;
    }

    return formatSize + "&nbsp;" + fileMesure;
};

appHelper.uploadFiles = function (i, files, url, properties, callback) {
    if (files) {
        if (files.length > 0) {
            $.ajax({
                url: appServiceUrl.odataFileUrl + url,
                type: 'POST',
                data: appHelper.formData(i, files),
                processData: false,
                contentType: false,
                success: function (data) {
                    var F = {};
                    var t = [];
                    //var  = 0;
                    for (var j = 0; j < data.length; j++) {
                        t.push(data[j]);
                    }
                    F.FSended = t;
                    F.Type = properties.Type;
                    F.ID = properties.ID;
                    //$.post(appServiceUrl.fileUrl + 'addproperties/',
                    $.post(appServiceUrl.odataFileUrl + 'addproperties/',
                        F,
                        function () {
                            i++;
                            if (i < files.length) {
                                appHelper.uploadFiles(i, files, url, properties, callback);
                            } else {
                                if (callback) {
                                    callback.call();
                                }
                            }
                        });
                }
            });
        }
        else {
            if (callback) {
                callback.call();
            }
        }
    }
    else {
        if (callback) {
            callback.call();
        }
    }
};

appHelper.uploadReunionFiles = function (i, files, url, properties, callback) {
    if (files) {
        appHelper.uploadFiles(i, files, url, properties, callback);
        //if (files.length > 0) {
        //    $.ajax({
        //        url: url,
        //        type: 'POST',
        //        data: appHelper.formData(i, files),
        //        processData: false,
        //        contentType: false,
        //        success: function (data) {
        //            var F = {};
        //            var t = [];
        //            //var  = 0;
        //            for (var j = 0; j < data.length; j++) {
        //                t.push(data[j]);
        //            }
        //            F.FSended = t;
        //            F.Type = properties.Type;
        //            F.ID = properties.ID;
        //            $.post(appServiceUrl.odataFileUrl + 'addproperties/',
        //                F,
        //                function () {
        //                    i++;
        //                    if (i < files.length) {
        //                        appHelper.uploadReunionFiles(i, files, url, properties, callback);
        //                    } else {
        //                        if (callback) {
        //                            callback.call();
        //                        }
        //                    }
        //                });
        //        }
        //    });
    }
    //    else {
    //        if (callback) {
    //            callback.call();
    //        }
    //    }
    //}
    else {
        if (callback) {
            callback.call();
        }
    }
};

appHelper.cryptUrl = function (str) {
    var loc = str.toLowerCase();
    var nl = "";
    for (var i = 0; i < loc.length; i++) {
        nl = nl + String.fromCharCode(loc.charCodeAt(i) + 5);
    }
    return nl
        .replaceAll("?", "#a#")
        .replaceAll("&", "#b#")
        .replaceAll("+", "#c#")
        .replaceAll("}", "#d#")
        .replaceAll("{", "#e#")
        .replaceAll("(", "#f#")
        .replaceAll(")", "#g#")
        .replaceAll("%", "#h#")
        .replaceAll("'", "#i#")
        .replaceAll('"', "#j#")
        .replaceAll("[", "#k#")
        .replaceAll("]", "#l#")
        .replaceAll("=", "#m#")
        .replaceAll(">", "#n#")
        .replaceAll("<", "#o#")
        .replaceAll("^", "#p#");
};

appHelper.uncryptUrl = function (str) {
    var loc = str
        .replaceAll("#a#", "?")
        .replaceAll("#b#", "&")
        .replaceAll("#c#", "+")
        .replaceAll("#d#", "}")
        .replaceAll("#e#", "{")
        .replaceAll("#f#", "(")
        .replaceAll("#g#", ")")
        .replaceAll("#h#", "%")
        .replaceAll("#i#", "'")
        .replaceAll("#j#", '"')
        .replaceAll("#k#", "[")
        .replaceAll("#l#", "]")
        .replaceAll("#m#", "=")
        .replaceAll("#n#", ">")
        .replaceAll("#o#", "<")
        .replaceAll("#p#", "^");

    var nl = "";
    for (var i = 0; i < loc.length; i++)
        nl = nl + String.fromCharCode(loc.charCodeAt(i) - 5);
    return nl;
};

appHelper.setLocalStorage = function (data) {
    localStorage.setItem("PROFILE_IMG_SRC", data.Image.ID ? data.Image.Base64Content : "assets/img/no-profile-pic.png");
    localStorage.setItem("PROFILE_NAME", data.NomComplet);
    localStorage.setItem("PROFILE_LOGIN", $('#inputEmail').val());
    localStorage.setItem("PROFILE_SESSION_ID", data.Email + "_" + new Date().getTime());
    localStorage.setItem("PROFILE_REAUTH_EMAIL", data.Email);
    localStorage.setItem("PROFILE_REAUTH_EMAIL", data.Email);
    localStorage.setItem("PROFILE_REAUTH_OBJ", data);
    localStorage.setItem("PROFILE_EMPLOYEEID", data.EmployeeId);
    localStorage.setItem("PROFILE_USERID", data.ID);
    localStorage.setItem("PROFILE_OWNERORGID", data.OwnerOrgId);
    localStorage.setItem("PROFILE_LASTDATECONNECTED", data.DateDerniereConnexion);
    //localStorage.setItem("PROFILE_CAN_EDIT", "1");
    //localStorage.setItem("PROFILE_CAN_DELETE", "1");
    //localStorage.setItem("PROFILE_CAN_EXECUTE", "1");

    //alert(localStorage.getItem("PROFILE_USERID"));
    //alert(localStorage.getItem("PROFILE_OWNERORGID"));
};

appHelper.DataHighChart = function (T, Param) {
    var data = [];
    switch (Param) {
        //case "CANCELED": for (var i = 0; i < T.length; i++) data.push([T[i].Title, T[i].Cancel]); break;
        //case "INTERNAL": for (var i = 0; i < T.length; i++) data.push([T[i].Title, T[i].Internal]); break;
        //case "EXTERNAL": for (var i = 0; i < T.length; i++) data.push([T[i].Title, T[i].External]); break;
        case "TOTAL":
            for (var i = 0; i < T.length; i++) {
                data.push({
                    name: T[i].Title,
                    y: T[i].Total
                });
            }
            break;
        //case "GUERITE": for (var i = 0; i < T.length; i++) data.push([T[i].Name, T[i].Total]); break;
    }
    return data;
};

appHelper.GetHighChart = function (T, DivID, Param, Title, color) {
    if (color) {
        //console.log(color)
        window.Highcharts.chart(DivID, {
            chart: {
                plotBackgroundColor: null,
                plotBorderWidth: null,
                plotShadow: false,
                type: 'pie'
            },
            title: {
                text: Title
            },
            colors: color,
            tooltip: {
                pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
            },
            plotOptions: {
                pie: {
                    allowPointSelect: true,
                    cursor: 'pointer',
                    dataLabels: {
                        enabled: true,
                        format: '<b>{point.name}</b>: {point.percentage:.1f} %',
                        style: {
                            color: (window.Highcharts.theme && window.Highcharts.theme.contrastTextColor) || 'black'
                        }
                    }
                }
            },
            series: [{
                name: '%',
                colorByPoint: true,
                data: appHelper.DataHighChart(T, Param)
            }]
        });
    }
    else {
        window.Highcharts.chart(DivID, {
            chart: {
                plotBackgroundColor: null,
                plotBorderWidth: null,
                plotShadow: false,
                type: 'pie'
            },
            title: {
                text: Title
            },
            tooltip: {
                pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
            },
            plotOptions: {
                pie: {
                    allowPointSelect: true,
                    cursor: 'pointer',
                    dataLabels: {
                        enabled: true,
                        format: '<b>{point.name}</b>: {point.percentage:.1f} %',
                        style: {
                            color: (window.Highcharts.theme && window.Highcharts.theme.contrastTextColor) || 'black'
                        }
                    }
                }
            },
            series: [{
                name: '%',
                colorByPoint: true,
                data: appHelper.DataHighChart(T, Param)
            }]
        });
    }
};

appHelper.ListenAjaxEvent = function (Type, inDivContener) {
    $(document).ajaxComplete(function (event, xhr, settings) {
        var config = {
            Title: "",
            Message: "",
            Type: Type,
            Div: inDivContener
        };
        config.Message = xhr.responseText;
        switch (xhr.status) {
            case objHelper.Enum.StatusCode.UserNonAuth:
                config.Title = "Unauthenticated user";
                appHelper.ShowAllTypeMessage(config.Title, config.Message, config.Type, config.Div);
                break;
            case objHelper.Enum.StatusCode.AccesRefused:
                config.Title = "Access denied";
                appHelper.ShowAllTypeMessage(config.Title, config.Message, config.Type, config.Div);
                break;
            case objHelper.Enum.StatusCode.PageNoFound:
                config.Title = "Adress not found";
                appHelper.ShowAllTypeMessage(config.Title, config.Message, config.Type, config.Div);
                break;
            case objHelper.Enum.StatusCode.ServerError:
                config.Title = "Server Error";
                appHelper.ShowAllTypeMessage(config.Title, config.Message, config.Type, config.Div);
                break;
            case objHelper.Enum.StatusCode.InternalError:
                config.Title = "Server Error";
                appHelper.ShowAllTypeMessage(config.Title, config.Message, config.Type, config.Div);
                break;
            case objHelper.Enum.StatusCode.ServerNotResponsed:
                config.Title = "The server did not respond";
                appHelper.ShowAllTypeMessage(config.Title, config.Message, config.Type, config.Div);
                break;
        }
    });
};

appHelper.PermissionChecker = function () {
    if (!app.userPermission.Editing) {
        $("*[data-Permission='Editing']").addClass("is-disabled-perm");
    } else {
        $("*[data-Permission='Editing']").removeClass("is-disabled-perm");
    }

    if (!app.userPermission.Listing) {
        $("*[data-Permission='Listing']").addClass("is-disabled-perm");
    } else {
        $("*[data-Permission='Listing']").removeClass("is-disabled-perm");
    }

    if (!app.userPermission.Deleting) {
        $("*[data-Permission='Deleting']").addClass("is-disabled-perm");
    } else {
        $("*[data-Permission='Deleting']").removeClass("is-disabled-perm");
    }

    if (!app.userPermission.Canceling) {
        $("*[data-Permission='Canceling']").addClass("is-disabled-perm");
    } else {
        $("*[data-Permission='Canceling']").removeClass("is-disabled-perm");
    }

    if (!app.userPermission.Executing) {
        $("*[data-Permission='Executing']").addClass("is-disabled-perm");
    } else {
        $("*[data-Permission='Executing']").removeClass("is-disabled-perm");
    }
}

appHelper.ShowAllTypeMessage = function (Title, Message, Type, inDivContener) {
    switch (Type) {
        case objHelper.Enum.AllMessageType.InDiv:

            if (!inDivContener.startsWith("#")) {
                inDivContener = '#' + inDivContener.trim();
            }
            var str = '<div class="alert alert- danger">' +
                '<h4>' + Title + '</h4>' +
                Message + '</div >';
            $(inDivContener).append(str);

            break;
        case objHelper.Enum.AllMessageType.InPopup:

            bootbox.dialog({
                message: Message + '<br/> <em class="text-danger">escape for close</em>',
                title: Title,
                closeButton: false,
                backdrop: true,
                onEscape: true
            });

            break;
        case objHelper.Enum.AllMessageType.InGritter:

            $.gritter.add({
                title: Title,
                text: Message,
                class_name: 'gritter-warning  gritter-light'
            });

            break;
    }
};


appHelper.calculSimulation = function (Depart, Periodicite, Duree, Taux, Montant) {

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
     
    DateDepart = new Date(helper.ReturnInternationnalDate(Depart, 'FR', '/'));

    RetourHTML += "<table width='100%' class='table table-bordered table-hover' cellpadding='0' cellspacing='0'>";

    RetourHTML += "<tr align='left' valign='top'>"; 

    RetourHTML += "<td colspan='9' style='backgroud-color:#1522'><h3>Ce tableau d'amortissement est à titre indicatif</h3></td>";
    RetourHTML += "</tr>";

    RetourHTML += "<tr align='left' valign='top' class='TRListeEntete'>";
    RetourHTML += "<td width='40px' align='center'>N° Ech</td>";
    RetourHTML += "<td width='70px' align='center'>Date</td>";
    RetourHTML += "<td width='100px' align='right'>Amort</td>";
    RetourHTML += "<td width='100px' align='right'>Amort. Cumul</td>";
    RetourHTML += "<td width='70px' align='right'>Interêt</td>"; 
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
 
    for (var i = 1; i <= NbMois; i++) {
        if (i === 1) {
            var Interm = 0; var Interm2 = 0;
            Interm = parseFloat(M * ((T / PER) + (T * TPS) / PER));
             
            Interm2 = parseFloat(1 + (T / PER) + (T * TPS / PER));

            Amort = (Interm) / (Math.pow(Interm2, (PER * D)) - 1);
            Amort1 = Amort;
            Interet = parseFloat(M * T / PER);
            MTPS = parseFloat(Interet * TPS);
             
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

    return RetourHTML;

};
