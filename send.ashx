<%@ WebHandler Language="C#" Class="send" %>

using System;
using System.Web;
using System.Net.Mail;
using System.IO;
public class send : IHttpHandler
{

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
        if (context.Request == null)
        {
            context.Response.Write("系统异常，请重试");
            return;
        }

        string mail, pageName, ip, browser;

        mail =   context.Request["parmes"];
        pageName = context.Request.QueryString["pageName"];
        ip = context.Request.UserHostAddress;
        browser = "";
        if (context.Request.Browser != null)
        {
            HttpBrowserCapabilities bc = context.Request.Browser;
            browser = string.Format("浏览器类型：{0}-{1}，版本：{2}，平台：{3}，是否为网络爬虫：{4}", bc.Type, bc.Browser, bc.Version, bc.Platform, bc.Crawler);
        }

        if (string.IsNullOrWhiteSpace(mail))
        {
            context.Response.Write("未提供有效的联系方式，请重试");
            return;
        }



        if (SentMailHXD("eric@bitshine.com.cn", mail, "123", "李自强", "456"))
        {
            context.Response.Write("发送成功");
        }
        else

        {
            context.Response.Write("发送失败");
        }
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }
    public static void WriteLog(Exception ex, string LogAddress = "")
    {
        
        StreamWriter fs = new StreamWriter("C:\\fabu\\qituo\\log1.txt", true);
        fs.WriteLine("当前时间：" + DateTime.Now.ToString());
        fs.WriteLine("异常信息：" + ex.Message);
        fs.WriteLine("异常对象：" + ex.Source);
        fs.WriteLine("调用堆栈：\n" + ex.StackTrace.Trim());
        fs.WriteLine("触发方法：" + ex.TargetSite);
        fs.WriteLine();
        fs.Close();
    }



public static bool SentMailHXD(string to, string body, string title,  string path, string Fname)
{
    bool retrunBool = false;
    MailMessage mail = new MailMessage();
    SmtpClient smtp = new SmtpClient("smtp.sina.com",587);
    smtp.EnableSsl = true;
    smtp.UseDefaultCredentials = false;
    string strFromEmail = "2029174723@qq.com";
    string strEmailPassword = "zyulxndefggybecj";
    try
    {
        mail.From = new MailAddress("" + Fname + "<" + strFromEmail + ">");
        mail.To.Add(new MailAddress(to));

        mail.IsBodyHtml = true;

        mail.Priority = MailPriority.Normal;
        mail.Body = body;
        mail.Subject = title;
        smtp.Host = "smtp.qq.com";
        smtp.DeliveryMethod = SmtpDeliveryMethod.Network;
        smtp.Credentials = new System.Net.NetworkCredential(strFromEmail, strEmailPassword);
        //发送邮件  
    smtp.Send(mail);     //同步发送  
        retrunBool = true;
    }
    catch (Exception ex)
    {
        WriteLog(ex);
        retrunBool = false;
    }
    // //异步发送 （异步发送时页面上要加上Async="true" ）  
    return retrunBool;
}
}
