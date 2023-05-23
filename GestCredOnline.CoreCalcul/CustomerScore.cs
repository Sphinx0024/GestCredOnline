namespace GestCredOnline.CoreCalcul
{
    public class CustomerScore
    {
        public int Score { get; set; } //[100...0]
        public int Note { get; set; } //[9...0]
        public string Risque { get; set; } // {FAIBLE, MOYEN, ELEVE}

        public static void CalculNote(ref CustomerScore Scr)
        {
            Scr.Note = GetNote(Scr.Score);
            Scr.Risque = GetRisque(Scr.Note);
        }

        private static string GetRisque(int note)
        {
            if (note < 4) { return Mapping.Risque_Basse_Libelle; }
            else if (note < 7) { return Mapping.Risque_Moyen_Libelle; }
            else { return Mapping.Risque_Eleve_Libelle; }
        }

        private static int GetNote(int score)
        {
            if (score < 21) { return 9; }
            else if (score < 31) { return 8; }
            else if (score < 41) { return 7; }
            else if (score < 51) { return 6; }
            else if (score < 61) { return 5; }
            else if (score < 71) { return 4; }
            else if (score < 81) { return 3; }
            else if (score < 91) { return 2; }
            else if (score < 101) { return 1; }
            else return 0;
        }
    }
}