using Microsoft.AspNetCore.Mvc;
using System.ComponentModel.DataAnnotations;

namespace i321.Controllers
{

    [Route("[controller]")]
    [ApiController]
    public class CommandeController(ApplicationContext context) : ControllerBase
    {

        private readonly ApplicationContext _context = context;

        [HttpGet]
        public ActionResult<IEnumerable<commandes>> GetAll() 
        {
            return _context.commandes.ToList();
        }

        [HttpGet("{id:int}")]
        public ActionResult<commandes> Get(int id)
        {

           var commande = _context.commandes.Find(id);

           if (commande == null)
           {
               return NotFound();
           }
           return Ok(commande);
        }

        [HttpPost]
        public ActionResult<commandes> InsertCommande(commandes commande)
        {
           _context.commandes.Add(commande);

           try
           {
               _context.SaveChanges();
           }
           catch (Exception ex)
           {
               return BadRequest(ex.Message);
           }
           return Ok(commande);
        }

        [HttpPut("{id:int}")]
        public ActionResult<IEnumerable<commandes>> Patch([FromRoute]int id, commandes commande)
        {
           if(id != commande.Id)
           {
               return BadRequest();
           }

           var commandeToPatch = _context.commandes.Find(id);

           if(commandeToPatch == null)
           {
               return NotFound(id);
           }

           commandeToPatch.statut = commande.statut;
           commandeToPatch.total = commande.total;
           commandeToPatch.date_commande = DateTime.UtcNow;

           try
           {
               _context.SaveChanges();
           }
           catch (Exception ex)
           {
               return NotFound(ex.Message);
           }

           return Ok(commande);
        }

        [HttpDelete("{id:int}")]
        public ActionResult<IEnumerable<commandes>> Delete(int id)
        {
           var command = _context.commandes.Find(id);

           if (command == null)
           {
               return NotFound(id);

           }
           _context.commandes.Remove(command);

           return Ok("command delete");
        }
    }
}
