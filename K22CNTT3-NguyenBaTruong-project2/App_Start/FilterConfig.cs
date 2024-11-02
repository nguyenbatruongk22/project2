using System.Web;
using System.Web.Mvc;

namespace K22CNTT3_NguyenBaTruong_project2
{
    public class FilterConfig
    {
        public static void RegisterGlobalFilters(GlobalFilterCollection filters)
        {
            filters.Add(new HandleErrorAttribute());
        }
    }
}
