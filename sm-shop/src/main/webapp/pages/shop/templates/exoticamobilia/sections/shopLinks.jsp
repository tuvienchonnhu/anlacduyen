<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="s" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<%@ page session="false" %>

		<script src="<c:url value="/resources/templates/exoticamobilia/js/jquery-1.11.1.min.js" />"></script>

		<!-- CORE CSS -->
		<link href="<c:url value="/resources/templates/exoticamobilia/css/bootstrap.css" />" rel="stylesheet" type="text/css">

		<!-- more fonts, cursor up -->
        <link href="<c:url value="/resources/templates/exoticamobilia/css/fontello.css" />" rel="stylesheet" type="text/css">
        <link href="<c:url value="/resources/templates/exoticamobilia/css/magnific-popup.css" />" rel="stylesheet" type="text/css">
       

		<link href="<c:url value="/resources/templates/exoticamobilia/css/responsive-slider.css" />" rel="stylesheet" type="text/css">
		<link rel="icon" href="<c:url value="/resources/templates/exoticamobilia/img/favicon.ico"/> "> 
		
		<!--  Theme -->

		<link href="<c:url value="/resources/templates/exoticamobilia/css/style.css" />" rel="stylesheet" type="text/css">
		<link href="<c:url value="/resources/templates/exoticamobilia/css/template.css" />" rel="stylesheet" type="text/css">
		<link href="<c:url value="/resources/templates/exoticamobilia/font-awesome-4.2.0/css/font-awesome.css" />" rel="stylesheet" type="text/css">
		
		
		<link href="<c:url value="/resources/templates/exoticamobilia/css/dark_gray.css" />" rel="stylesheet" type="text/css">

    
    	<!-- generic and common css file -->
    	<link href="<c:url value="/resources/css/sm.css" />" rel="stylesheet">
    	<link href="<c:url value="/resources/css/showLoading.css" />" rel="stylesheet">
    
    	<!-- ////////////// -->
    	

<!--

//-->
</script>

    <!-- mini shopping cart template -->
    <script type="text/html" id="miniShoppingCartTemplate">
		{{#shoppingCartItems}}
			<tr id="{{productId}}" class="cart-product">
				<td>
			{{#image}}
					<img width="40" src="{{contextPath}}{{image}}">
			{{/image}}
			{{^image}}
					&nbsp;
			{{/image}}
				</td>
				<td>{{quantity}}</td>
				<td>{{name}}</td>
				<td>{{price}}</td>
				<td><button productid="{{productId}}" class="close removeProductIcon" onclick="removeItemFromMinicart('{{id}}')">x</button></td>
			</tr>
		{{/shoppingCartItems}}
	</script>
	
	<c:if test="${requestScope.CONFIGS['google_analytics_url'] != null}">	
	<!-- Google Analytics 4 (gtag.js) - Universal Analytics (ga.js) da bi Google khai tu tu 7/2023 -->
	<script async src="https://www.googletagmanager.com/gtag/js?id=<c:out value="${requestScope.CONFIGS['google_analytics_url']}"/>"></script>
	<script type="text/javascript">
	//<![CDATA[
		  window.dataLayer = window.dataLayer || [];
		  function gtag(){dataLayer.push(arguments);}
		  gtag('js', new Date());
		  gtag('config', '<c:out value="${requestScope.CONFIGS['google_analytics_url']}"/>');
	//]]> 
	</script>
	</c:if>
	
	