namespace GestCredOnline.CoreCalcul
{
    public class ScoringCriteriaSalarie : ScoringCriteria
    {
        public int Profession { get; set; }
        public float TauxPret { get; set; }
        public int Grade { get; set; }
        public int NombreAnneeEmployeurExistance { get; set; }
        public bool EmployeurEstAgree { get; set; }
        public int SegmentEmployeur { get; set; }
    }
}