var helper = helper || {};

helper.PageAffichee = "";

//helper.mainContentDiv = "#divAppContent";
(function ($, window) {
    $.fn.contextMenu = function (settings) {
        return this.each(function () {
            // Open context menu
            $(this).on("contextmenu", function (e) {
                // return native menu if pressing control
                if (e.ctrlKey) return;

                //open menu
                var $menu = $(settings.menuSelector)
                    .data("invokedOn", $(e.target))
                    .show()
                    .css({
                        position: "absolute",
                        left: getMenuPosition(e.clientX, 'width', 'scrollLeft'),
                        top: getMenuPosition(e.clientY, 'height', 'scrollTop')
                    })
                    .off('click')
                    .on('click', 'a', function (e) {
                        $menu.hide();
                        var $invokedOn = $menu.data("invokedOn");
                        var $selectedMenu = $(e.target);
                        settings.menuSelected.call(this, $invokedOn, $selectedMenu);
                    });

                return false;
            });

            //make sure menu closes on any click
            $('body').click(function () {
                $(settings.menuSelector).hide();
            });
        });

        function getMenuPosition(mouse, direction, scrollDir) {
            var win = $(window)[direction](),
                scroll = $(window)[scrollDir](),
                menu = $(settings.menuSelector)[direction](),
                position = mouse + scroll - 100;

            // opening menu would pass the side of the page
            if (mouse + menu > win && menu < mouse) {
                position -= menu;
            }
            return position;
        }
    };
})(jQuery, window);

String.prototype.replaceAll = function (search, replacement) {
    var target = this;
    return target.replace(new RegExp(search, 'g'), replacement);
};

String.prototype.addthousandSepFr = function () {
    var nStr = this;
    nStr += '';
    x = nStr.split(',');
    x1 = x[0];
    x2 = x.length > 1 ? ',' + x[1] : '';
    var rgx = /(\d+)(\d{3})/;
    while (rgx.test(x1)) {
        x1 = x1.replace(rgx, '$1' + ' ' + '$2');
    }
    return x1 + x2;
};

Number.prototype.addthousandSepFr = function () {
    var nStr = this;
    nStr += '';
    x = nStr.split(',');
    x1 = x[0];
    x2 = x.length > 1 ? ',' + x[1] : '';
    var rgx = /(\d+)(\d{3})/;
    while (rgx.test(x1)) {
        x1 = x1.replace(rgx, '$1' + ' ' + '$2');
    }
    return x1 + x2;
};

Number.prototype.padLeft = function (base, chr) {
    var len = (String(base || 10).length - String(this).length) + 1;
    return len > 0 ? new Array(len).join(chr || '0') + this : this;
};

String.prototype.reverse = function () {
    return this.split('').reverse().join('');
};

Array.prototype.getUnique = function () {
    var u = {}, a = [];
    for (var i = 0, l = this.length; i < l; ++i) {
        if (u.hasOwnProperty(this[i])) {
            continue;
        }
        a.push(this[i]);
        u[this[i]] = 1;
    }
    return a;
};

Array.prototype.clean = function (cleanValue) {
    for (var i = 0; i < this.length; i++) {
        if (this[i] === cleanValue) {
            this.splice(i, 1);
            i--;
        }
    }
    return this;
};

String.prototype.getInitialOfName = function () {
    var t = this.split(" ");
    t = t.clean(" ");
    t = t.getUnique();
    var l = t.length;
    var r = "";
    for (var i = 0; i < l; ++i) {
        r += t[i].charAt(0).toUpperCase();
    }
    return r;
};

helper.redirection = function (urlcomplet, divContenu) {
    // helper.redirection(urlcomplet, divContenu, null);
    sessionStorage.setItem("ajax_url", urlcomplet);
    helper.ChargerPageGET(urlcomplet, divContenu, function () {
        helper.CacherLoader(divContenu);
        setTimeout(function () {/* helper.controleSecurity(); */}, 200);
        return false;
    });
};

helper.redirection = function (urlcomplet, divContenu, FonctionCallBack) {
    sessionStorage.setItem("ajax_url", urlcomplet);
    helper.ChargerPageGET(urlcomplet, divContenu, function () {
        if (FonctionCallBack) {
            FonctionCallBack.call();
        }
        helper.CacherLoader(divContenu);
        setTimeout(function () {
            /*helper.controleSecurity();*/
        }, 200);
        return false;
    });
};

helper.isFunction = function (variableToCheck) {
    if (variableToCheck instanceof Function) {
        return true;
    }
    return false;
};

helper.GetQueryString = function (param) {
    var vars = {};
    sessionStorage.getItem("ajax_url").toLowerCase().replace(location.hash, '').replace(
        /[?&]+([^=&]+)=?([^&]*)?/gi, // regexp
        function (m, key, value) { // callback
            vars[key] = value !== undefined ? value : '';
        }
    ); 
    if (param) {
        return vars[param.toLowerCase()] ? decodeURI(vars[param.toLowerCase()]) : null;
    }
    return vars;
};

helper.getUrlVars = function (url) {
    var vars = [];
    url = new URL(url); 
    for (var ar of url.searchParams.entries()) {
        //query minuscule
        vars.push(ar[0].toLowerCase());
        vars[ar[0].toLowerCase()] = ar[1]; 
        //query majuscule
        vars.push(ar[0].toUpperCase());
        vars[ar[0].toUpperCase()] = ar[1]; 
        //exactly
        vars.push(ar[0]);
        vars[ar[0]] = ar[1];
    } 
    return vars;
};

helper.RegroupItemBy = function (data, field) {
    // this gives an object with dates as keys
    const groups = data.reduce((groups, item) => {
        const value = item[field];
        if (!groups[value]) {
            groups[value] = [];
        }
        groups[value].push(item);
        return groups;
    }, {});

    // Edit: to add it in the array format instead
    const groupArrays = Object.keys(groups).map((value) => {
        return {
            value,
            items: groups[value]
        };
    });

    return groupArrays;
};


helper.ReturnInternationnalDate = function(dateValue, lang, separateur) {
    retour = "02/02/2015";
    T = dateValue.split("/");
    if (T.length == 3) {
        switch (lang) {
            case "FR":
                retour = T[2] + separateur + T[1] + separateur + T[0];
                break;
            case "EN":
                retour = T[2] + separateur + T[0] + separateur + T[1];
                break;
        }
    }
    return retour;

}


helper.getUrlVars.old = function (url) {
    var vars = [], hash;
    var hashes = url.slice(url.indexOf('?') + 1).split('&');

    for (var i = 0; i < hashes.length; i++) {
        hash = hashes[i].split('=');
        //query minuscule
        vars.push(hash[0].toLowerCase());
        vars[hash[0].toLowerCase()] = hash[1];

        //query majuscule
        vars.push(hash[0].toUpperCase());
        vars[hash[0].toUpperCase()] = hash[1];

        //exactly
        vars.push(hash[0]);
        vars[hash[0]] = hash[1];
    }

    //console.log(vars);
    return vars;
};

helper.PrintHtmlDoc = function (selector, title, header) {
    var divContents = $(selector).html();
    var printWindow = window.open('', '', 'height=400,width=800');
    printWindow.document.write('<html><head>' + header + '<title>' + title + '</title>');
    printWindow.document.write('</head><body>');
    printWindow.document.write(divContents);
    printWindow.document.write('</body></html>');
    printWindow.document.close();
    printWindow.print();
};

helper.ReturnISODate = function (frenchDate, heure) {
    if (!heure) {
        heure = "08:00";
    } 
    if (!frenchDate) {
        frenchDate = helper.ToLocalDateString(new Date());
    } 
    return helper.ReturnInternationnalDate(frenchDate, "FR", "-") + "T" + heure + ":00.000Z";
};

helper.ToLocalDateString = function (isoDate) {
    var date = new Date(isoDate);
    return (date.getDate() < 10 ? "0" + date.getDate() : date.getDate()) +
        "/" +
        (date.getMonth() < 9
            ? "0" + (date.getMonth() + 1)
            : date.getMonth() + 1) +
        "/" +
        date.getFullYear();
};

helper.ReturnInternationnalDate = function (dateValue, lang, separateur) {
    var retour = "02/02/2015";
    var t = dateValue.split("/");
    if (t.length === 3) {
        switch (lang) {
            case "FR":
                retour = t[2] + separateur + t[1] + separateur + t[0];
                break;
            case "EN":
                retour = t[2] + separateur + t[0] + separateur + t[1];
                break;
        }
    }
    return retour;
};

helper.noBack = function () {
    window.history.forward(1);
};

helper.ShowProgressPostBack = function (divAtraiter) {
    divAtraiter = divAtraiter !== null ? $(divAtraiter) : $(window);
    setTimeout(function () {
        var modal = $('<div />');
        modal.addClass("PostBackmodal");
        modal.addClass("PostBackloading");
        modal.offset(divAtraiter.offset());
        modal.height(divAtraiter.height());
        modal.width(divAtraiter.width());
        $('body').append(modal);
        var loading = $(".PostBackloading");
        loading.show();
        var top = Math.max(divAtraiter.height() / 2 - loading[0].offsetHeight, 0);
        var left = Math.max(divAtraiter.width() / 2 - loading[0].offsetWidth / 2, 0);
        loading.css({ top: top, left: left });
    }, 200);

    //setTimeout(function () {
    //    var DivaTraiter = DivAcouvrir != null ? $(DivAcouvrir) : window;
    //    var modal = $('<div />');
    //    modal.addClass("PostBackmodal");
    //    modal.offset(DivaTraiter.offset())
    //    modal.height(DivaTraiter.height())
    //    modal.width(DivaTraiter.width())
    //    $('body').append(modal);
    //    var loading = $(".PostBackloading");
    //    loading.show();
    //    var top = Math.max(DivaTraiter.offset().top + DivaTraiter.height() / 2, 0);
    //    var left = Math.max(DivaTraiter.offset().left + DivaTraiter.width() / 2 , 0);
    //    loading.css({ top: top, left: left });
    //}, 200);
};

helper.HideProgressPostBack = function () {
    $(".PostBackloading").hide();
    $(".PostBackmodal").remove();
};

helper.DeleteData = function (eltValid, pageGet, fonctionCallBack) {
    var info = "";
    if (eltValid === "SUPDATA") {
        var action = "supprimer";
        info += "&action=" + action;
    }
    $.ajax({
        type: "GET",
        data: info,
        url: pageGet,
        cache: false,
        success: function () {
            if (fonctionCallBack !== null) {
                fonctionCallBack.call();
            }
            alert("Suppression effectuée avec succès");
        },
        error: function () {
            //alert("echec de l'opération, une erreur s'est produite lors de l'opération!!!")
        },
        complete: function () {
            $("#DivManagerOver").hide();
        }
    });
};

helper.ValidateFileExtension = function (validFilesTypes, fileUploadId) {
    var fileUploadSelector = $(fileUploadId);
    var path = fileUploadSelector.val();
    var ext = path.substring(path.lastIndexOf(".") + 1, path.length).toLowerCase();
    var isValidFile = false;
    for (var i = 0; i < validFilesTypes.length; i++) {
        if (ext === validFilesTypes[i]) {
            isValidFile = true;
            break;
        }
    }

    return isValidFile;
};

helper.AffichePopupPageGet = function (pageACharger, divACharger, divACouvrir, largeur, hauteur, titre, fonctionCallBack, fonctionCallBackCancel) {
    var divAtraiter = $(divACharger);

    if (divAtraiter.hasClass("MyPopup")) {
        divAtraiter.dialog("close");
    }

    $(divACharger).hide();

    helper.ChargerPageGET(pageACharger, divACharger, function () {
        helper.CacherLoaderPopup(divACouvrir);
        divAtraiter.addClass("MyPopup");
        //alert("in")
        //$(DivACharger).show();
        $(divACharger).dialog({
            resizable: false,
            minWidth: largeur,
            modal: true,
            title: titre,
            hide: 'fold',
            show: "blind",
            beforeClose: function (event, ui) {
                divAtraiter.removeClass("MyPopup");
            },
            buttons: {
                "Valider": function () {
                    if (fonctionCallBack !== null) {
                        fonctionCallBack.call();
                    }
                    else {
                        $(this).dialog("close");
                    }
                },

                "Annuler": function () {
                    if (fonctionCallBackCancel !== null) {
                        fonctionCallBackCancel.call();
                    }
                    $(this).dialog("close");
                }
            }
        });
    });
};

helper.AfficherLoaderPopup = function (divACouvrir, largeur, hauteur) {
    if (divACouvrir !== null) {
        var divTraite = $(divACouvrir);
        var loader = $("<div id='" + divTraite.attr('id') + "Loader' class='DivLoaderPopup'></div>");
        var width; var height;
        var top = divTraite.offset().top;
        var left = divTraite.offset().left;
        if (largeur !== null) { width = largeur; }
        else { width = divTraite.width(); }
        if (hauteur !== null) { height = hauteur; }
        else { height = divTraite.height(); }
        if (!divTraite.hasClass("ALoader")) {
            divTraite.addClass("ALoader");
            $("#myloaderwrap").addClass('opacityOverflow');
            loader.css('width', width).css('height', height).css('z-index', 10000).css('top', top).css('left', left).css('opacity', '0.7');
            loader.appendTo('body').show();
        }
    }
};

helper.CacherLoaderPopup = function (divACouvrir) {
    if (divACouvrir !== null) {
        var divTraite = $(divACouvrir);
        var loader = $("#" + divTraite.attr('id') + "Loader");
        if (loader !== null) {
            if (loader !== 'undefined') {
                if (divTraite.hasClass("ALoader")) {
                    loader.remove();
                    $("#myloaderwrap").removeClass('opacityOverflow');
                    divTraite.removeClass("ALoader");
                }
            }
        }
    }
};

helper.ErreurDeValidation = function (popup, message) {
    popup.empty();
    popup.append("<font class='Message'><br><br>&nbsp;" + message + "</font>");
    popup.dialog({
        resizable: false,
        width: 500,
        modal: true,
        title: "Erreur de validation",
        buttons: {
            "OK": function () {
                $(this).dialog("close");
            }
        }
    });
};

helper.ConfirmationDeSuppression = function (popup, message, fonctionCallBack) {
    popup.empty();
    popup.append("<font class='Message'><br><br>&nbsp;" + message + "<br>&nbsp;Cette action est irreversible. Confirmez vous la suppression ?</font>");
    popup.dialog({
        resizable: false,
        width: 500,
        modal: true,
        title: "Confirmer la suppression",
        buttons: {
            "OK": function () {
                $(this).dialog("close");
                if (fonctionCallBack !== null) {
                    fonctionCallBack.call();
                }
            },
            "Annuler": function () {
                $(this).dialog("close");
            }
        }
    });
};

helper.AutoCompletionStart = function (it, donneesurl, event) {
    var that = $(it);
    var autoCompletionIdSelector = $("#autoCompletionDiv" + that.attr("id") + "");
    //<%--var elt = $("#<%=TxtEntrepriseNonAgr.ClientID%>")--%>
    var position = that.offset();
    if (event.type === "keyup") {
        if (event.which === 13) {
            if (autoCompletionIdSelector.length) {
                autoCompletionIdSelector.remove();
                return false;
            }
            else {
                return false;
            }
        }

        autoCompletionIdSelector.offset({ top: position.top + that.height() + 2, left: position.left }).width(that.width() + 2).slideDown(1000)
        helper.ChargerPageGETAvecLoader(donneesurl,
            autoCompletionIdSelector,
            autoCompletionIdSelector,
            null,
            null,
            function () {
            });
    }
    else if (event.type === "focus") {
        //alert("iii")
        if (!autoCompletionIdSelector.length) {
            var divResultat = "<div class='autoCompletionClass' id='autoCompletionDiv" + that.attr("id") + "'></div>";
            that.after(divResultat);
            autoCompletionIdSelector.offset({ top: position.top + that.height() + 2, left: position.left }).width(that.width() + 2).show();
            //autoCompletionIDSelector.hide();
            return false;
        }
    }
    else {
        if ($(".tdTest").hasClass("empty"))
            if (autoCompletionIdSelector.length) {
                autoCompletionIdSelector.remove();
                return false;
            }
    }
};

helper.OuvrirMessagePopup = function (message, width, titre, fonctionCallBack) {
    var over = "";
    var wraper = "";

    over += "<div class='modal' id='SelectionOverlay'>";
    over += "<div class='contentWrap'><font class='Message'><br><br>&nbsp;" + message + "<br><br></div>";
    over += "</div>";

    $('#SelectionOverlay').remove();
    $('body').append(over);

    $('#SelectionOverlay').dialog({
        resizable: false,
        width: width,
        modal: true,
        title: titre,
        buttons: {
            "OK": function () {
                $(this).dialog("close");
                if (fonctionCallBack !== null) {
                    var retour = fonctionCallBack.call();
                }
            }
        }
    });
};

helper.CalculateZIndex = function (element, defaultZIndex) {
    //console.log("___111___" + defaultZIndex);

    var biggestZIndex = parseInt(defaultZIndex ? defaultZIndex : 0);

    element.parents().each(function (index, parent) {
        var zIndex = parseInt($(parent).css('z-index'));
        if (zIndex && zIndex !== 'auto') {
            zIndex = parseInt(zIndex);
            if (zIndex > biggestZIndex) {
                biggestZIndex = zIndex;
            }
        }
    });

    if (!biggestZIndex) {
        var zIndex = parseInt(element.css('z-index'));
        if (zIndex && zIndex !== 'auto') {
            zIndex = parseInt(zIndex);
            if (zIndex > biggestZIndex) {
                biggestZIndex = zIndex;
            }
        }
    }
    return biggestZIndex;
};

helper.AfficherLoader = function (divACouvrir, largeur, hauteur) {
    if (divACouvrir) {
        //divACouvrir = appConfig.divAppContent ? appConfig.divAppContent : "#divAppContent";

        var divTraite = $(divACouvrir);

        //divTraite.addClass("divContent");

        var loader = $("<div id='" + divTraite.attr('id') + "Loader' class='DivLoader divContent'>....</div>");

        ///console.log(loader.css("z-index"));

        var zindex = helper.CalculateZIndex(divTraite, loader.css("z-index"));

        //console.log(zindex);

        var width; var height;
        var top = divTraite.offset().top;
        var left = divTraite.offset().left;
        if (largeur !== null) { width = largeur; }
        else { width = divTraite.width(); }
        if (hauteur !== null) { height = hauteur; }
        else { height = divTraite.height(); }
        loader.css('width', width).css('height', height).css('z-index', zindex + 1).css('top', top).css('left', left).css('opacity', '0.7');
        loader.appendTo("body").show();

        var intervalId =
            setInterval(function () {
                if ($("#" + divTraite.attr("id") + "Loader").length > 0) {
                    if (divTraite.length === 0) {
                        loader.remove();
                        clearInterval(intervalId);
                    }
                }
                else {
                    loader.remove();
                    clearInterval(intervalId);
                }
            }, 1000);
    }
};

helper.CacherLoader = function (divACouvrir) {
    $('.DivLoader').each(function () {
        var $that = $(this);
        var id = '#' + $that.attr('id').toString().replace('Loader', '');
        $parent = $(id);
        if (($parent.length === 0)) {
            $that.remove();
        }
    });

    if (divACouvrir) {
        // if (Loader !== 'undefined') {
        var divTraite = $(divACouvrir);
        var loader = $("#" + divTraite.attr('id') + "Loader");
        loader.remove();
        //  }
    }
};

helper.RegroupItemBy = function (data, field) {
    // this gives an object with dates as keys
    const groups = data.reduce((groups, item) => {
        const value = item[field];
        if (!groups[value]) {
            groups[value] = [];
        }
        groups[value].push(item);
        return groups;
    }, {});

    // Edit: to add it in the array format instead
    const groupArrays = Object.keys(groups).map((value) => {
        return {
            value,
            items: groups[value]
        };
    });
    return groupArrays;
};

helper.ChargerDataGET = function (dataUrl, divACouvrir, fonctionCallBack) {
    $.ajax({
        type: "GET",
        //data: "",
        url: dataUrl,
        cache: false,
        success: function (data) {
            if (fonctionCallBack) {
                fonctionCallBack(data);
            }
        },
        beforeSend: function (xhr) {
            if (localStorage.getItem(appConfig.connectTokenType)) {
                if (localStorage.getItem(appConfig.connectToken)) {
                    xhr.setRequestHeader("Authorization", localStorage.getItem(appConfig.connectTokenType) + " " + localStorage.getItem(appConfig.connectToken));
                }
            }
        },
        error: function (event, jqxhr, settings, thrownError) {
            if (divACouvrir) {
                $(divACouvrir).empty();
                $(divACouvrir).append(thrownError);
            } else {
                alert(thrownError);
            }
            helper.redirectByError(event, jqxhr, settings, thrownError);
        },
        complete: function () {
            //if (divACouvrir) {
            helper.CacherLoader(divACouvrir);
            //helper.PermissionChecker();
            //}
        }
    });
};

helper.ChargerDataGETAvecLoader = function (dataUrl, divACharger, divACouvrir, largeur, hauteur, fonctionCallBack) {
    helper.AfficherLoader(divACouvrir, largeur, hauteur);
    helper.ChargerDataGET(dataUrl, divACouvrir, fonctionCallBack);
};

helper.ChargerPageGET = function (PageACharger, DivACharger, fonctionCallBack) {
    $.ajax({
        type: "GET",

        data: "",
        url: PageACharger,
        cache: false,
        beforeSend: function (xhr) {
            if (localStorage.getItem(appConfig.connectTokenType)) {
                if (localStorage.getItem(appConfig.connectToken)) {
                    xhr.setRequestHeader("Authorization", localStorage.getItem(appConfig.connectTokenType) + " " + localStorage.getItem(appConfig.connectToken));
                }
            }
        },
        success: function (msg) {
            if (DivACharger) {
                //alert(DivACharger)
                $(DivACharger).empty();
                $(DivACharger).append(msg);
            }

            if (fonctionCallBack) {
                fonctionCallBack.call();
            }

            // console.log("permission" + new Date().toISOString());

            //helper.PermissionChecker();
        },

        error: function (event, jqxhr, settings, thrownError) {
            $(DivACharger).empty();
            $(DivACharger).append(jqxhr.responseText);
            helper.redirectByError(event, jqxhr, settings, thrownError);
        },
        complete: function () {
            //helper.PermissionChecker();
        }
    });
};

helper.ChargerPageGETAvecLoader = function (PageACharger, DivACharger, DivACouvrir, Largeur, Hauteur, fonctionCallBack) {
    helper.AfficherLoader(DivACouvrir, Largeur, Hauteur);
    helper.ChargerPageGET(PageACharger, DivACharger, function () {
        helper.CacherLoader(DivACouvrir);
        if (fonctionCallBack) {
            fonctionCallBack.call();
        }
    });
};

helper.ChargerPagePOST = function (pageACharger, donnees, divACharger, divACouvrir, fonctionCallBack) {
    $.ajax({
        type: "POST",
        data: donnees,
        url: pageACharger,
        cache: false,
        beforeSend: function (xhr) {
            if (localStorage.getItem(appConfig.connectTokenType)) {
                if (localStorage.getItem(appConfig.connectToken)) {
                    xhr.setRequestHeader("Authorization", localStorage.getItem(appConfig.connectTokenType) + " " + localStorage.getItem(appConfig.connectToken));
                }
            }
        },
        success: function (msg) {
            if (fonctionCallBack) {
                fonctionCallBack(msg);
            }
        },

        error: function (event, jqxhr, settings, thrownError) {
            if (divACharger) {
                $(divACharger).empty();
                $(divACharger).append("Raté mec");
            } else {
                alert("Raté mec");
            }
            helper.redirectByError(event, jqxhr, settings, thrownError);
        },
        complete: function () {
            helper.CacherLoader(divACouvrir);
        }
    });
};

helper.ChargerPagePOSTAvecLoader = function (pageACharger, donnees, divACharger, divACouvrir, largeur, hauteur, fonctionCallBack) {
    helper.AfficherLoader(divACouvrir, largeur, hauteur);
    helper.ChargerPagePOST(pageACharger, donnees, divACharger, divACouvrir, fonctionCallBack);
};

helper.OuvrirPageEnPopup = function (titre, pageAcharger, width, height, fonctionCallBack) {
    var over = "";
    var wraper = "";
    over += "<div class='modal' id='PageOverlay'>";
    over += "<div class='contentWrap'></div>";
    over += "</div>";
    $('#PageOverlay').remove();
    $('body').append(over);
    $('#PageOverlay').dialog({
        resizable: false,
        width: width,
        height: height,
        modal: true,
        title: titre,
        buttons: {
            "Fermer": function () {
                if (fonctionCallBack !== null) {
                    fonctionCallBack.call();
                }
                $(this).dialog("close");
            }
        },
        create: function () {
            wraper = $(this).find(".contentWrap");
            helper.ChargerPageGET(pageAcharger, wraper, function () { });
        }
    });
};

helper.ChargerPageExterne = function (titre, pageAcharger, width, height, fonctionCallBack) {
    //var donnees = "";
    helper.OuvrirPageEnPopup(titre, pageAcharger, width, height, fonctionCallBack);
};

helper.generateUUID = function () {
    var d = new Date().getTime();
    var uuid = 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function (c) {
        var r = (d + Math.random() * 16) % 16 | 0;
        d = Math.floor(d / 16);
        return (c === 'x' ? r : (r & 0x3 | 0x8)).toString(16);
    });
    return uuid;
};

helper.loadJS = function (scriptName, scriptUrl) {
    var head = document.getElementsByTagName('head').item(0);
    var js = document.getElementById(scriptName);
    if (js) {
        helper.unloadJS(scriptName);
    }
    js = document.createElement('script');
    js.id = scriptName;
    js.src = appFolder.appUrl + scriptUrl + "?time=" + new Date().getTime();
    document.getElementsByTagName('head')[0].appendChild(js);
};

helper.unloadJS = function (scriptName) {
    var head = document.getElementsByTagName('head').item(0);
    var js = document.getElementById(scriptName);
    js.parentNode.removeChild(js);
    //callback.call();
};

helper.unloadAllJS = function () {
    var jsArray = new Array();
    jsArray = document.getElementsByTagName('script');
    for (i = 0; i < jsArray.length; i++) {
        if (jsArray[i].id) {
            helper.unloadJS(jsArray[i].id)
        } else {
            jsArray[i].parentNode.removeChild(jsArray[i]);
        }
    }
};

helper.removeEmptyvalue = function (value) {
    if (value) {
        return value.replace('null', "_");
    }
    else {
        return '_';
    }
};

helper.redirectByError = function (event, jqxhr, settings, thrownError) {
    if (event.status.toString() === "401") {
        localStorage.setItem(appConfig.connectProfile, null);
        window.location.href = "login.aspx";
    }
};

//helper.TestGroup = function (name) {
//    var v = false;
//    if (name) {
//        if (localStorage[appConfig.groupSouscrit]) {
//            var str = localStorage[appConfig.groupSouscrit].toString().split(";");
//            if (str.indexOf(name.toString().toUpperCase()) > -1) { v = true; }
//        }
//    }
//    return v;
//};

//helper.controleSecurity = function () {
//    var selector = '';

//    if (helper.TestGroup(appConfig.SecurityGroups.LECTEURS.GroupName)) {
//        selector = '.' + appConfig.SecurityGroups.LECTEURS.Selector;
//    }

//    if (helper.TestGroup(appConfig.SecurityGroups.EDITEURS.GroupName)) {
//        selector = '.' + appConfig.SecurityGroups.EDITEURS.Selector;
//    }

//    if (helper.TestGroup(appConfig.SecurityGroups.COLLABORATEURS.GroupName)) {
//        selector = '.' + appConfig.SecurityGroups.COLLABORATEURS.Selector;
//    }

//    if (helper.TestGroup(appConfig.SecurityGroups.ADMINISTRATEUR.GroupName)) {
//        selector = '.' + appConfig.SecurityGroups.ADMINISTRATEUR.Selector;
//    }

//    if (selector !== '') {
//        $(selector).show();
//    } else {
//        if (($('#Page_403_unauth').length === 0)) {
//            helper.redirection('unauth_403.html', appConfig.divMainContent);
//        }
//    }
//};

helper.Odata = {};

helper.Odata.save = function (url, data, fonctionCallBack) {
    $.ajax({
        url: appServiceUrl.odataServiceUrl + url,
        type: 'POST',
        contentType: "application/json;charset=utf-8",
        data: JSON.stringify(data),
        beforeSend: function (xhr) {
            if (localStorage.getItem(appConfig.connectTokenType)) {
                if (localStorage.getItem(appConfig.connectToken)) {
                    xhr.setRequestHeader("Authorization", localStorage.getItem(appConfig.connectTokenType) + " " + localStorage.getItem(appConfig.connectToken));
                }
            }
        },
        success: function (data) {
            $('.DivLoader').remove();
            if (fonctionCallBack !== null) {
                fonctionCallBack(data);
            }
        },
        error: function (event, jqxhr, settings, thrownError) {
            helper.redirectByError(event, jqxhr, settings, thrownError);
        }
    });
};

helper.Odata.getted = function (url, DivACharger, fonctionCallBack) {
    helper.ChargerDataGET(appServiceUrl.odataServiceUrl + url, DivACharger, fonctionCallBack);
};

//helper.Odata.get = function (url, DivACharger, DivACouvrir, Largeur, Hauteur, fonctionCallBack) {
//    helper.ChargerDataGETAvecLoader(appServiceUrl.odataServiceUrl + url, DivACharger, DivACouvrir, Largeur, Hauteur, fonctionCallBack);
//};
 
helper.Odata.get = function (url, DivACharger, DivACouvrir, Largeur, Hauteur, fonctionCallBack) {

    $.ajax({
        url: appServiceUrl.odataServiceUrl + url,
        type: 'Get',
        beforeSend: function (xhr) {
            if (localStorage.getItem(appConfig.connectTokenType)) {
                if (localStorage.getItem(appConfig.connectToken)) {
                    xhr.setRequestHeader("Authorization", localStorage.getItem(appConfig.connectTokenType) + " " + localStorage.getItem(appConfig.connectToken));
                }
            }
        },
        contentType: "application/json; charset=utf-8", 
        success: function (data) {
            if (fonctionCallBack) {
                fonctionCallBack(data);
                //helper.CacherLoader(divACouvrir);
            }
        },
        error: function (event, jqxhr, settings, thrownError) {
            helper.redirectByError(event, jqxhr, settings, thrownError);
        }
    });

};


helper.Odata.put = function (url, data, fonctionCallBack) {
    //helper.AfficherLoader(divACouvrir, largeur, hauteur);
    $.ajax({
        url: appServiceUrl.odataServiceUrl + url,
        type: 'PUT',
        beforeSend: function (xhr) {
            if (localStorage.getItem(appConfig.connectTokenType)) {
                if (localStorage.getItem(appConfig.connectToken)) {
                    xhr.setRequestHeader("Authorization", localStorage.getItem(appConfig.connectTokenType) + " " + localStorage.getItem(appConfig.connectToken));
                }
            }
        },
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify(data),
        success: function (data) {
            if (fonctionCallBack) {
                fonctionCallBack(data);
                //helper.CacherLoader(divACouvrir);
            }
        },
        error: function (event, jqxhr, settings, thrownError) {
            helper.redirectByError(event, jqxhr, settings, thrownError);
        }
    });
};

helper.Odata.patched = function (url, data, fonctionCallBack) {
    //helper.AfficherLoader(divACouvrir, largeur, hauteur);
    $.ajax({
        url: appServiceUrl.odataServiceUrl + url,
        type: 'PATCH',
        beforeSend: function (xhr) {
            if (localStorage.getItem(appConfig.connectTokenType)) {
                if (localStorage.getItem(appConfig.connectToken)) {
                    xhr.setRequestHeader("Authorization", localStorage.getItem(appConfig.connectTokenType) + " " + localStorage.getItem(appConfig.connectToken));
                }
            }
        },
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify(data),
        success: function () {
            if (fonctionCallBack) {
                fonctionCallBack.call();
                //helper.CacherLoader(divACouvrir);
            } else {
                //helper.CacherLoader(divACouvrir);
            }
        },
        error: function (event, jqxhr, settings, thrownError) {
            helper.redirectByError(event, jqxhr, settings, thrownError);
        }
    });
};

helper.Odata.patch = function (url, data, divACouvrir, largeur, hauteur, fonctionCallBack) {
    helper.AfficherLoader(divACouvrir, largeur, hauteur);
    $.ajax({
        url: appServiceUrl.odataServiceUrl + url,
        type: 'PATCH',
        beforeSend: function (xhr) {
            if (localStorage.getItem(appConfig.connectTokenType)) {
                if (localStorage.getItem(appConfig.connectToken)) {
                    xhr.setRequestHeader("Authorization", localStorage.getItem(appConfig.connectTokenType) + " " + localStorage.getItem(appConfig.connectToken));
                }
            }
        },
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify(data),
        success: function () {
            if (fonctionCallBack) {
                fonctionCallBack.call();
                helper.CacherLoader(divACouvrir);
            } else {
                helper.CacherLoader(divACouvrir);
            }
        },
        error: function (event, jqxhr, settings, thrownError) {
            helper.redirectByError(event, jqxhr, settings, thrownError);
        }
    });
};

helper.Odata.delete = function (url, divACouvrir, largeur, hauteur, fonctionCallBack) {
    helper.AfficherLoader(divACouvrir, largeur, hauteur);
    $.ajax({
        url: appServiceUrl.odataServiceUrl + url,
        type: 'DELETE',
        beforeSend: function (xhr) {
            if (localStorage.getItem(appConfig.connectTokenType)) {
                if (localStorage.getItem(appConfig.connectToken)) {
                    xhr.setRequestHeader("Authorization", localStorage.getItem(appConfig.connectTokenType) + " " + localStorage.getItem(appConfig.connectToken));
                }
            }
        },
        success: function () {
            if (fonctionCallBack) {
                fonctionCallBack.call();
                helper.CacherLoader(divACouvrir);
            } else {
                helper.CacherLoader(divACouvrir);
            }
        },
        error: function (event, jqxhr, settings, thrownError) {
            helper.redirectByError(event, jqxhr, settings, thrownError);
        }
    });
};