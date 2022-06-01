<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        
        <center>
        <br/><br/></br>
        <div class="invoice">
        <h1>Invoice</h1>
        <%
            Connection c ;
            Statement st;
            c=DriverManager.getConnection("jdbc:derby://localhost:1527/jsp");
            st=c.createStatement();
            String books="";
            
            ResultSet rs=st.executeQuery("select * from Book");
            long total=0;
            
             rs.next();
             
             if( Integer.parseInt(request.getParameter("first"))!=0){
             
             long num=Integer.parseInt(rs.getString(4))* Integer.parseInt(request.getParameter("first"));
             books+=rs.getString(1) +" ";
             %>
             <% out.print(rs.getString(1)); %>
             <% out.print(Integer.parseInt(request.getParameter("first"))) ;%>
             <% out.println(Integer.parseInt(rs.getString(4)));%>
             <<% out.println(num) ;%>
             <%
             total+=num;
             int updated=Integer.parseInt(rs.getString(3)) -  Integer.parseInt(request.getParameter("first")) ;
                 
             Statement sm=c.createStatement();
             int result=sm.executeUpdate("UPDATE BOOK SET quantity="+updated+" WHERE BOOKNAME='"+rs.getString(1)+"'");
            }
            
            rs.next();
             
             if(Integer.parseInt(request.getParameter("second"))!=0){
             long num=Integer.parseInt(rs.getString(4))* Integer.parseInt(request.getParameter("second"));
             
             total+=num;
             int updated=Integer.parseInt(rs.getString(3)) -  Integer.parseInt(request.getParameter("first")) ;
             Statement sm=c.createStatement();
             int result=sm.executeUpdate("UPDATE BOOK SET quantity="+updated+" WHERE BOOKNAME='"+rs.getString(1)+"'");
               books+=rs.getString(1)  +" ";
              %>
              
             <%out.print(rs.getString(1)); %>
             <% out.print(Integer.parseInt(request.getParameter("second"))) ;%>
             <% out.println(Integer.parseInt(rs.getString(4)));%>
             <% out.println(num) ;%>
}
  <%          
             rs.next();
             
             if( Integer.parseInt(request.getParameter("third"))!=0){
             num=Integer.parseInt(rs.getString(4))* Integer.parseInt(request.getParameter("third"));
             
             total+=num;
             books+=rs.getString(1)  +" ";
             updated=Integer.parseInt(rs.getString(3)) -  Integer.parseInt(request.getParameter("first")) ;
             Statementsm=c.createStatement();
             result=sm.executeUpdate("UPDATE BOOK SET quantity="+updated+" WHERE BOOKNAME='"+rs.getString(1)+"'");
             
  %>
  
 	     <%out.print(rs.getString(1));%>
             <% out.print(Integer.parseInt(request.getParameter("third"))) ;%>
             <% out.println(Integer.parseInt(rs.getString(4)));%>
             <% out.println(num) ;%>  
  <%
            }
            
           sm=c.createStatement();
           result=sm.executeQuery("SELECT purchased FROM CUSTOMER WHERE NAME='"+session.getAttribute("name")+"'");
           result.next();
           Statement update=c.createStatement();
           books += result.getString(1);
           int res=update.executeUpdate("UPDATE CUSTOMER SET PURCHASED='"+books+"' WHERE NAME='"+session.getAttribute("name")+"'");
            
%>
	     </br></br>
             Total Amount:<h1> <% out.println(total); %></h1>
            </div>
    </center> 
    </body>
</html>