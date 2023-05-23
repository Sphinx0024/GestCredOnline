namespace GestCredOnline.CoreCalcul
{
    public static class CalculScoring
    {
        public static CustomerScore CalculScore(ScoringCriteriaExploitant Critere)
        {
            CustomerScore _Score = new CustomerScore();

            //PROFESSION: EXPLOITANT AGRICOLE
            //non           0
            //OUI           8
            if (Critere.EstExploitantAgricole) { _Score.Score += 8; }
            else { _Score.Score += 0; }

            //ANCIENNETE
            // <= 3 ans          0
            //   ]3 - 6 ans]     8
            //   ]6 - 9 ans]     4
            //      > 9 ans      3
            if (Critere.Anciennete > 9) { _Score.Score += 3; }
            else if (Critere.Anciennete > 6) { _Score.Score += 4; }
            else if (Critere.Anciennete > 3) { _Score.Score += 8; }
            else { _Score.Score += 0; }

            //LE CLIENT A TIL UN COMPTE D'EPARGNE
            //OUI           0
            //NON           8
            if (Critere.EstEpargnant) { _Score.Score += 8; }
            else { _Score.Score += 0; }

            // TAUX D'ENDETTEMENT
            //<= 15 %               0
            //  ]15 % -23 %]        7
            //  ]23 % -33 %]        10
            //       > 33 %         18
            if (Critere.TauxEndettement > 0.33) { _Score.Score += 18; }
            else if (Critere.TauxEndettement > 0.23) { _Score.Score += 10; }
            else if (Critere.TauxEndettement > 0.15) { _Score.Score += 7; }
            else { _Score.Score += 0; }

            //TOTAL REVENU
            //<= 300000                         2
            //   300000 < Revenu < 700000       1
            //          >= 700 000              0
            if (Critere.TotalRevenu > 699999) { _Score.Score += 0; }
            else if (Critere.TotalRevenu > 300000) { _Score.Score += 1; }
            else { _Score.Score += 2; }

            //NAIONNALITE
            //AUTRES               8
            //COTE D'IVOIRE        0
            if (Critere.Nationnalite.ToUpper() == Mapping.CIV_Nationnalite) { _Score.Score += 0; }
            else { _Score.Score += 8; }

            //SEXE
            //F         0
            //M         10
            if (Critere.Sexe == 'F') { _Score.Score += 0; }
            else if (Critere.Sexe == 'M') { _Score.Score += 10; }

            //ÂGE
            //<= 35 ans               5
            //  ]35 - 45 ans]         2
            //  ]45 - 55 ans]         2
            //      > 55 ans          0
            if (Critere.Age > 55) { _Score.Score += 0; }
            else if (Critere.Age > 45) { _Score.Score += 2; }
            else if (Critere.Age > 35) { _Score.Score += 2; }
            else { _Score.Score += 5; }

            //DUREE DU PRËT
            //<= 18 mois             10
            //  [19 - 36 mois]       7
            //  [37 - 60 mois]       5
            //      > 60 mois        0
            if (Critere.DureePret > 60) { _Score.Score += 0; }
            else if (Critere.DureePret > 37) { _Score.Score += 5; }
            else if (Critere.DureePret > 19) { _Score.Score += 7; }
            else { _Score.Score += 10; }

            CustomerScore.CalculNote(ref _Score);
            return _Score;
        }

        public static CustomerScore CalculScore(ScoringCriteriaSalarie Critere)
        {
            CustomerScore _Score = new CustomerScore();

            switch (Critere.Profession)
            {
                case (int)Mapping.MetierClient.ENSEIGNANTPUBLIC:
                    _Score.Score += 8;
                    break;

                case (int)Mapping.MetierClient.ENSEIGNANTPRIVE:
                    _Score.Score += 8;
                    break;

                case (int)Mapping.MetierClient.FONCTIONNAIRE:
                    _Score.Score += 5;
                    break;

                case (int)Mapping.MetierClient.SALARIEPRIVE:
                    _Score.Score += CalculScoreSalariePrive(Critere);
                    break;
            }

            if (Critere.TauxPret < 8.5) { _Score.Score += 0; } else { _Score.Score += 3; }

            if (Critere.DureePret > 60) { _Score.Score += 0; }
            else if (Critere.DureePret > 36) { _Score.Score += 2; }
            else if (Critere.DureePret > 18) { _Score.Score += 5; }
            else { _Score.Score += 9; }

            if (Critere.Anciennete > 9) { _Score.Score += 2; }
            else if (Critere.Anciennete > 5) { _Score.Score += 5; }
            else if (Critere.Anciennete > 3) { _Score.Score += 7; }
            else { _Score.Score += 0; }

            if (Critere.TotalRevenu > 450000) { _Score.Score += 0; }
            else if (Critere.TotalRevenu > 250000) { _Score.Score += 2; }
            else { _Score.Score += 7; }

            if (Critere.EstEpargnant) { _Score.Score += 11; } else { _Score.Score += 0; }

            CustomerScore.CalculNote(ref _Score);
            return _Score;
        }

        private static int CalculScoreSalariePrive(ScoringCriteriaSalarie Critere)
        {
            int scr = 0;

            switch (Critere.Grade)
            {
                case (int)Mapping.MetierGradeClient.Assitant:
                    scr += 4;
                    break;

                case (int)Mapping.MetierGradeClient.Maitrise:
                    scr += 3;
                    break;

                case (int)Mapping.MetierGradeClient.Cadre:
                    scr += 1;
                    break;

                case (int)Mapping.MetierGradeClient.Responsable:
                    scr += 0;
                    break;

                case (int)Mapping.MetierGradeClient.SousDirecteur:
                    scr += 0;
                    break;

                case (int)Mapping.MetierGradeClient.Directeur:
                    scr += 0;
                    break;
            }

            if (Critere.TotalRevenu < 400001)
            {
                if (Critere.TauxEndettement > 0.33) { scr += 7; }
                else if (Critere.TauxEndettement > 0.31) { scr += 3; }
                else if (Critere.TauxEndettement > 0.20) { scr += 1; }
                else { scr += 0; }

                if (Critere.NombreAnneeEmployeurExistance > (20 * 12)) { scr += 0; }
                else if (Critere.NombreAnneeEmployeurExistance > (10 * 12)) { scr += 1; }
                else if (Critere.NombreAnneeEmployeurExistance > (5 * 12)) { scr += 5; }
                else if (Critere.NombreAnneeEmployeurExistance > (18)) { scr += 8; }
                else { scr += 10; }

                if (Critere.Age > 45) { scr += 0; }
                else if (Critere.Age > 35) { scr += 2; }
                else { scr += 0; }

                if (Critere.EmployeurEstAgree) { scr += 7; }
            }

            if (Critere.TotalRevenu < 250001)
            {
                switch (Critere.SegmentEmployeur) 
                {
                    case (int)Mapping.EmployeurSegment.TPE: scr += 5; break;
                    case (int)Mapping.EmployeurSegment.PME: scr += 2; break;
                    case (int)Mapping.EmployeurSegment.GE: scr += 0; break;
                    case (int)Mapping.EmployeurSegment.Etatique: scr -= 6; break;
                }
            }

            return scr;
        }
    }
}