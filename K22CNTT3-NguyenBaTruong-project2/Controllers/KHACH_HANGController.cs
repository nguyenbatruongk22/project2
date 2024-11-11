using K22CNTT3_NguyenBaTruong_project2.Models;
using System.Linq;
using System.Web.Mvc;
using System.Web.Security;

public class KHACH_HANGController : Controller
{
    private PhukienthucungEntities db = new PhukienthucungEntities();

    // GET: KHACH_HANG/Login
    public ActionResult Login()
    {
        return View();
    }

    // POST: KHACH_HANG/Login
    [HttpPost]
    [ValidateAntiForgeryToken]
    public ActionResult Login(string Tai_khoan, string Mat_khau)
    {
        if (string.IsNullOrWhiteSpace(Tai_khoan) || string.IsNullOrWhiteSpace(Mat_khau))
        {
            ModelState.AddModelError("", "Tài khoản và mật khẩu không được để trống");
            return View();
        }

        // Check user credentials
        var user = db.KHACH_HANG.FirstOrDefault(kh => kh.Tai_khoan == Tai_khoan && kh.Mat_khau == Mat_khau);

        if (user != null)
        {
            FormsAuthentication.SetAuthCookie(user.Tai_khoan, false);
            return RedirectToAction("Index", "Home");
        }
        else
        {
            ModelState.AddModelError("", "Tài khoản hoặc mật khẩu không đúng");
            return View();
        }
    }

    // GET: KHACH_HANG/Logout
    public ActionResult Logout()
    {
        FormsAuthentication.SignOut();
        return RedirectToAction("Login");
    }
}
