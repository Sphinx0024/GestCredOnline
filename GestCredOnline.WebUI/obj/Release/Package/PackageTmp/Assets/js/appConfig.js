var appConfig = appConfig || {};

appConfig.divAppContent = "#DivAppContent";

appConfig.divMainContent = "#DivMainContent";

appConfig.connectToken = "ACCESTOKEN";
appConfig.connectTokenType = "ACCESTOKENTYPE";
appConfig.connectConnected = "PROFILE_CONNECTED";
appConfig.profileName = "PROFILE_NAME";


appConfig.Status = {
    Nouveau: 0,
    EnCours: 1,
    Annuler: 2,
    Valider: 3,
    Rejeter: 4,
    Closed: 5,
    PretPourArbitrage: 7,
    Archiver: 8,
    EnAttente: 9,
    Engager: 10,
    GetBorderColor: function (status) {
        switch (status) {
            case this.Nouveau: return 'status_new';
            case this.EnCours: return 'status_in_progress';
            case this.Annuler: return 'status_canceled';
            case this.Archiver: return 'status_archived';
            case this.Closed: return 'status_closed';
            case this.EnAttente: return 'status_waiting';
            case this.Engager: return 'status_engaged';
            case this.PretPourArbitrage: return 'status_arbitred';
            case this.Rejeter: return 'status_rejected';
            case this.Valider: return 'status_validated';
            default: return 'status_new';
        }
    },

    GetLabel: function (value) {
        var returns = "";
        $.each(this, function (i, v) {
            if (parseInt(v) === parseInt(value)) {
                returns = i;
                return;
            }
        });
        return returns;
    }
};
  
appConfig.Periodicite = {
    //Horaire: 0,
    //Quotidien: 1,
    //Hebdomadaire: 2,
    Mensuelle: 1,
    Bimestrielle: 2,
    Trimestrielle: 3,
    Semestrielle: 6,
    Annuelle: 12,
    GetLabelByValue: function (value) {
        let returns = "";
        $.each(this, function (i, v) { 
            if (parseInt(v) === parseInt(value)) { 
                returns = i;  return i;
            }
        });
        
        return returns;
    },

    CalculMontantAnnuelPeriodique: function (periodicite, montant) {
        switch (periodicite) {
            case this.Annuelle: return montant;
            case this.Semestrielle: return (montant / 2);
            case this.Bimestrielle: return (montant / 6);
            case this.Trimestrielle: return (montant / 4);
            case this.Mensuelle: return (montant / 12);
            case this.Hebdomadaire: return (montant / 52);
            case this.Quotidien: return (montant / 365);
            case this.Horaire: return (montant / 8760);
            default: return montant;
        }
    },

    GetNombreMois: function (periodicite) {
        switch (parseInt(periodicite)) {
            case this.Annuelle: return 12;
            case this.Bimestrielle: return (2);
            case this.Semestrielle: return (6);
            case this.Trimestrielle: return (3);
            case this.Mensuelle: return (1);
            case this.Hebdomadaire: return (1 / 4);
            case this.Quotidien: return (1 / 30);
            case this.Horaire: return (1 / 730.485 );
            default: return 1;
        }
    }

};

appConfig.StatusSync = {
    adding: 0,
    finished: 1,
    updating: 2,
    deleting :3
};


appConfig.SituationMatrimoniale = {
    Celibataire: { id: 1, libelle : 'Celibataire' },
    Veuf: { id: 2, libelle : 'Veuf(ve)' },
    Divorce: { id: 3, libelle : 'Divorcé(e)' },
    Communaute: { id: 4, libelle : 'Marié(e) - Communauté de biens' },
    Separation: { id: 5, libelle : 'Marié(e) - Séparation de biens' },

    GetSituationByIdentifiant: function (lib) {
        let returns = {};
        $.each(this, function (i, v) {
            if (i === lib) {
                returns = v; return i;
            }
        });
        return returns;
    },

    GetSituationById: function (id) {
        let returns = '';
        $.each(this, function (i, v) {
            if (v.id === id) {
                returns = i; return i;
            }
        });
        return returns;
    }

};