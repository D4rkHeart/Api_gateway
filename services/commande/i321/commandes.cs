using System.ComponentModel.DataAnnotations;

namespace i321
{
    public class commandes
    {
        [Key]
        public int id { get; set; }

        public int total { get; set; }

        public string statut { get; set; }

        public DateTime? date_commande { get; set; } = DateTime.UtcNow;
    }
}
