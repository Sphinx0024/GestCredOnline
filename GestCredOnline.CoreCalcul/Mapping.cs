namespace GestCredOnline.CoreCalcul
{
    public static class Mapping
    {
        public static string CIV_Nationnalite { get; set; } = "CIV";
        public static string Risque_Eleve_Libelle { get; set; } = "ELEVE";
        public static string Risque_Moyen_Libelle { get; set; } = "MOYEN";
        public static string Risque_Basse_Libelle { get; set; } = "FAIBLE";

        public enum MetierClient
        {
            ENSEIGNANTPUBLIC = 1,
            ENSEIGNANTPRIVE,
            FONCTIONNAIRE,
            SALARIEPRIVE
        }

        public enum MetierGradeClient
        {
            Assitant = 1,
            Maitrise,
            Cadre,
            Responsable,
            SousDirecteur,
            Directeur
        }

        public enum EmployeurSegment
        {
            TPE = 1,
            PME,
            GE,
            Etatique
        }
    }
}