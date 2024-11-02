using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using K22CNTT3_NguyenBaTruong_project2.Models;

namespace K22CNTT3_NguyenBaTruong_project2.Controllers
{
    public class LOAI_PHU_KIENController : Controller
    {
        private PhukienthucungEntities db = new PhukienthucungEntities();

        // GET: LOAI_PHU_KIEN
        public ActionResult Index()
        {
            return View(db.LOAI_PHU_KIEN.ToList());
        }

        // GET: LOAI_PHU_KIEN/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            LOAI_PHU_KIEN lOAI_PHU_KIEN = db.LOAI_PHU_KIEN.Find(id);
            if (lOAI_PHU_KIEN == null)
            {
                return HttpNotFound();
            }
            return View(lOAI_PHU_KIEN);
        }

        // GET: LOAI_PHU_KIEN/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: LOAI_PHU_KIEN/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "MaLoai,TenLoai,MoTa")] LOAI_PHU_KIEN lOAI_PHU_KIEN)
        {
            if (ModelState.IsValid)
            {
                db.LOAI_PHU_KIEN.Add(lOAI_PHU_KIEN);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            return View(lOAI_PHU_KIEN);
        }

        // GET: LOAI_PHU_KIEN/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            LOAI_PHU_KIEN lOAI_PHU_KIEN = db.LOAI_PHU_KIEN.Find(id);
            if (lOAI_PHU_KIEN == null)
            {
                return HttpNotFound();
            }
            return View(lOAI_PHU_KIEN);
        }

        // POST: LOAI_PHU_KIEN/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "MaLoai,TenLoai,MoTa")] LOAI_PHU_KIEN lOAI_PHU_KIEN)
        {
            if (ModelState.IsValid)
            {
                db.Entry(lOAI_PHU_KIEN).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(lOAI_PHU_KIEN);
        }

        // GET: LOAI_PHU_KIEN/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            LOAI_PHU_KIEN lOAI_PHU_KIEN = db.LOAI_PHU_KIEN.Find(id);
            if (lOAI_PHU_KIEN == null)
            {
                return HttpNotFound();
            }
            return View(lOAI_PHU_KIEN);
        }

        // POST: LOAI_PHU_KIEN/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            LOAI_PHU_KIEN lOAI_PHU_KIEN = db.LOAI_PHU_KIEN.Find(id);
            db.LOAI_PHU_KIEN.Remove(lOAI_PHU_KIEN);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
