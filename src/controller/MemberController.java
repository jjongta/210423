package controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import dao.MemberDao;
import dto.MemberDto;
import net.sf.json.JSONObject;

@WebServlet("/member")
public class MemberController extends HttpServlet {
	
	 ServletConfig mConfig = null;
	 final int BUFFER_SIZE = 8192;
	 
@Override
public void init(ServletConfig config) throws ServletException {
mConfig = config;   
}	 

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doProcess(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doProcess(req, resp);
	}
	
	public void doProcess(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("MemberController doProcess");
		req.setCharacterEncoding("utf-8");		
		
		String param = req.getParameter("param");
		
		if(param.equals("login")) {
			resp.sendRedirect("login_resist_form.jsp");
		}
		else if(param.equals("loginAf")) {
			System.out.println("MemberController loginAf");
			String userid = req.getParameter("userID");
			String userpwd = req.getParameter("userPassword");
			
			MemberDao dao = MemberDao.getInstance();
			MemberDto dto = dao.login(new MemberDto(userid, userpwd, null, null, 0, 0));
			
			 if(!userpwd.equals(dao.pwdCheck(userpwd))) {
	            String msg = "notEqual";
	          
	            resp.sendRedirect("message.jsp?msg=" + msg);               
	         }
	         else {
	         
		         if(dto != null ) {
		            req.getSession().setAttribute("login", dto);
		            resp.sendRedirect("main.jsp");
		         }else {
		            System.out.println("login ?????? ??????");
		      
		            resp.sendRedirect("login_resist_form.jsp");
		         }         
	         }

			
		}
		else if(param.equals("regi")) {
			resp.sendRedirect("regi.jsp");
		}
		else if(param.equals("regiAf")) {
			System.out.println("MemberController regiAf");
			String fupload = mConfig.getServletContext().getRealPath("/upload");
			
			 // ?????? ?????? - client
		    // String fupload = "d:\\tmp";

		    System.out.println("????????? ??????:" + fupload);
		    
		    String yourTempDir = fupload;
		    
		    //?????????????????????
		    //????????? ??????
		    int yourMaxRequestSize = 100 * 1024 * 1024;   // 1 Mbyte
		    int yourMaxMemorySize = 100 * 1024;         // 1 Kbyte	   
		    
		    // form field??? ???????????? ????????? ??????
		    String userID = "";
		    String userPWD = "";
		    String userName = "";
		    String userEmail = "";
		    String userPic = "";
		    String newuserPic = "";
		    
		    // file??? ??????
		    String filename = "";
		    
		    boolean isMultipart = ServletFileUpload.isMultipartContent(req);
		    if(isMultipart == true){
		    	
		    	// FileItem ??????
		        DiskFileItemFactory factory = new DiskFileItemFactory();
		        
		        factory.setSizeThreshold(yourMaxMemorySize);
		        factory.setRepository(new File(yourTempDir));
		        
		        //?????? ?????? ??? ?????????
		        ServletFileUpload upload = new ServletFileUpload(factory);
		        upload.setSizeMax(yourMaxRequestSize);
		        
		        List<FileItem> items = null;
		        try {
		           items = upload.parseRequest(req);
		        } catch (FileUploadException e) {
		           // TODO Auto-generated catch block
		           e.printStackTrace();
		        }
		        Iterator<FileItem> it = items.iterator();
		        
		    while(it.hasNext()){
		            
		        FileItem item = it.next();
		        
		        if(item.isFormField()){   // id, title, content
		             if(item.getFieldName().equals("userId")){
		                userID = item.getString("utf-8");
		             }
		             else if(item.getFieldName().equals("userPwd")){
		                userPWD = item.getString("utf-8");
		             }
		             else if(item.getFieldName().equals("userEmail")){
		                userName = item.getString("utf-8");
		             }else if(item.getFieldName().equals("userName")){
		                userEmail = item.getString("utf-8");
		             }else if(item.getFieldName().equals("img")){
		                userPic = item.getString("utf-8");
		             }else if(item.getFieldName().equals("newuserPic"))
		            	 newuserPic = item.getString("utf-8");
		                        System.out.println(userID + userPWD + userEmail + userName 
		            		 						+ userPic + newuserPic + "get Item input test");
		          }else {
		        	  
		        	  if(item.getFieldName().equals("photo-user")){
		        		  if(item.getName() != null && !item.getName().equals("")) {
			        		//????????????
			                  String fileName = item.getName();
			                  int lastInNum = fileName.lastIndexOf(".");
			                  
			                //?????????????????? ??????????????? ???????????? ex) .png
			                  String exName = fileName.substring(lastInNum);
			                  
			                  //????????? ?????????
			                  newuserPic = (new Date().getTime()) + "" + exName;
			                  filename = processUploadFile(item, newuserPic, fupload);
			                  
			                  System.out.println("newuserPic = "+ newuserPic);
			                  //filename??? ????????????
			                  //newfilename ????????? ??????
		        		  }
		               }
		            }      
		         }//while??? ??????
		    
		    
		    // ????????? ?????? ??????
		    System.out.println(userID + " " + userPWD + " " + userName + " " + userEmail + " " + userPic + " " + newuserPic);
			
		    MemberDao dao =  MemberDao.getInstance();
		       boolean isS = dao.insert(new MemberDto(userID, userPWD, userName, userEmail, newuserPic));
		       
		       String msg = "OK";
		       if(isS == false) {
		          msg = "NO";
		       }
		       resp.sendRedirect("message.jsp?msg=" + msg);
		    
		    }
		}  
		    
	 	else if (param.equals("login")) {
	 		resp.sendRedirect("login_resist_form.jsp");
	 	}
		    
	 	else if (param.equals("mapageAf")) {
	 		System.out.println("MemberController mapageAf");
	 		
	 		String userId = req.getParameter("userID");
	 		
	 		System.out.println(userId);
			
			MemberDao dao = MemberDao.getInstance();
			MemberDto dto = dao.getUserData(userId);
	 		
			if(dto != null ) {
				req.setAttribute("mapage", dto);
				System.out.println(dto.toString());
				req.getRequestDispatcher("mypage.jsp").forward(req, resp);
			}else {
				System.out.println("login ?????? ??????");
				resp.sendRedirect("member?param=login");
			}	
	 		
		
		}else if(param.equals("main")) {
			resp.sendRedirect("main.jsp");
		}
		
		else if(param.equals("deleteMember")) {
			System.out.println("MemberController deleteMember");
			 MemberDto mem = (MemberDto)req.getSession().getAttribute("login"); 
		    
			 String id = mem.getId();
			 String pw = mem.getPwd();
		     
		     System.out.println("id : " +id+ " pwd : " + pw);
			
		     req.getSession().invalidate(); 
			 MemberDao dao = MemberDao.getInstance();
			 boolean check = dao.deleteConfirm(id, pw);
	
			 String msg = "quitNO";
			 if(check) {
				 msg="quitYES";
				 resp.sendRedirect("quitMessage.jsp?msg=" + msg);
				/*
				 * out.println("<script>"); out.println("alert('??????????????? ?????? ???????????????.');");
				 * out.println("location.href='member?param=main';"); out.println("</script>");
				 */
			 } else {
				/*
				 * out.println("<script>"); out.println("alert('??????????????? ?????? ????????????.');");
				 * out.println("location.href='member?param=main';"); out.println("</script>");
				 */
				 
				 resp.sendRedirect("quitMessage.jsp?msg=" + msg);
		
				 
			 }
			
		}
		
		else if(param.equals("memUpdateAf")) {
			String id = req.getParameter("userId");
			String pwd = req.getParameter("userPwd");
			String name = req.getParameter("userName");
			String email = req.getParameter("userEmail");
			
			System.out.println(id+pwd);
			
			MemberDao dao = MemberDao.getInstance();
			
			String msg = "pwdNull";
			
			
			if(pwd.equals(dao.updateMemPwd(id))) {
			
				Boolean isS = dao.memUpdate(id, pwd, name, email);
			
				
				if(isS) {
					System.out.println("memUpdateAf isS");
					 msg = "updateInfo";
					
				
				}
				
				
				resp.sendRedirect("message.jsp?msg="+ msg);
				
			}
			else {
				resp.sendRedirect("message.jsp?msg="+ msg);
			}
			
		}
		
		
		else if(param.equals("Pwdcheck")) {
			System.out.println();
			String pwd = req.getParameter("pwd");
			System.out.println(pwd);
			MemberDao dao = MemberDao.getInstance();
			
			String msg = "YESPwd";
			
			if(!pwd.equals(dao.pwdCheck(pwd)) ) {
				 msg = "noPwd";
			}
				JSONObject jobj = new JSONObject();
				jobj.put("msg", msg);
				
				resp.setContentType("application/x-json; charset=UTF-8");
		         resp.getWriter().print(jobj);
				
			
		}
			
		else if(param.equals("idcheck")) {
			String id = req.getParameter("id");
			System.out.println("id:" + id);
			
			if(id != null && !id.equals("")) {
			
			MemberDao dao = MemberDao.getInstance();
			boolean b = dao.idCheck(id);
		
			
			String idcheck = "NO";
			if(b == false) {
				idcheck = "YES";
			}
			
			JSONObject jobj = new JSONObject();
			jobj.put("msg", idcheck);
			
			resp.setContentType("application/x-json; charset=UTF-8");
			resp.getWriter().print(jobj);
			}
		}

		else if(param.equals("memlist")) {
			System.out.println("memlist");
			String spage = req.getParameter("pageNumber");
		
			int page = 0;
			if(spage != null && !spage.equals("")) {
				page = Integer.parseInt(spage);
			}
			
			System.out.println("????????????");
			MemberDao dao = MemberDao.getInstance();
			List<MemberDto> list = dao.getAllMemPaging(page);
			
		
			req.setAttribute("list", list);
			System.out.println("memlist2");
			
			int len = dao.getAllMem();
			int memPage = len / 10;		// 23 -> 2
			if((len % 10) > 0){
				memPage = memPage + 1;
			}
			req.setAttribute("memPage", memPage + "");
			req.setAttribute("pageNumber", page + "");
							
			forward("mypagememlist.jsp", req, resp);
			
		}
		else if (param.equals("deleteMem")) {
	         System.out.println("deleteMem");
	         
	         String id = req.getParameter("id");
	         
	         MemberDao dao = MemberDao.getInstance();         
	         boolean b = dao.deleteMem(id);
	         
	         String msg = "DELETE";
	         if(b == false) {
	            msg = "";
	         }         
	         resp.sendRedirect("message.jsp?msg=" + msg);
	         
	         
	      }	
	}

	
	public String processUploadFile(FileItem fileItem, String newfilename, String dir)throws IOException{

		 String filename = fileItem.getName();   // ?????? + ?????????
		 //??????????????? ?????? ???????????? ???????????????.
		 
		 
		 
		 
		 long sizeInBytes = fileItem.getSize();
		 
		 if(sizeInBytes > 0){   // ????????? ???????      // d:\\tmp\\abc.txt d:/tmp/abc.txt 
		    //?????????????????? ????????????
		    
		    
		    //1
		    // \\?????? /??? ?????? ????????????????????? ????????? + ??????????????? ?????? ??????
		    int idx = filename.lastIndexOf("\\"); 
		    if(idx == -1){
		       idx = filename.lastIndexOf("/");
		    }
		    
		    
		    //2
		    //?????? ????????? \\,/??? ??????????????? ?????? ??????????????? +1??? ???????????????
		    
		    filename = filename.substring(idx + 1);
		    //File uploadFile = new File(dir, filename);
		    //??????????????????
		    File uploadFile = new File(dir, newfilename);
		    //????????? ????????? ?????????
		    //????????? ????????? ?????? ?????????????????? ????????? ???????????? ?????????
		    try{   
		       fileItem.write(uploadFile);      // ?????? upload?????? ??????
		    }catch(Exception e){
		       e.printStackTrace();
		    }      
		 }
		 return filename;   // DB??? ???????????? ?????? return;
		}
	
private void forward(String arg, HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	RequestDispatcher dispatch = req.getRequestDispatcher(arg);
	dispatch.forward(req, resp);
	
}
	
}

	
	

