<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:output method="html" indent="yes"/>
  <xsl:template match="/">
    <html>
      <head>
        <meta charset="UTF-8"/>
        <title><xsl:value-of select="documento/titulo"/></title>
        <link rel="stylesheet" href="style/estilos.css"/>
      </head>
      <body>
        <!--header  -->
        <header>
          <div class="head1">
            <img src="img/image.png" alt="logo"/>
          </div>
          <div class="navbar">
            <a href="#home">Inicio</a>
            <a class="active" href="#reserve">Reserva</a>
            <a href="#about">Sobre Nosotros</a>
          </div>
        </header>
        <!-- foto de equipo-->
        <div class="equipo">
          <img src="{empresa/equipo/imagen_equipo}" alt="Foto del equipo" class="imagen-equipo-trabajo"/>
        </div>
        <!-- historia -->
        <div class="historia">
          <h2>HISTORIA</h2>
          <p><xsl:value-of select="empresa/historia"/></p>
        </div>
        <!-- mision-vision-valores -->
        <div class="vision-mision-valores">
          <div class="mision">
            <h3>MISIÓN</h3>
            <p><xsl:value-of select="empresa/mision"/></p>
          </div>
          <div class="vision">
            <h3>VISIÓN</h3>
            <p><xsl:value-of select="empresa/vision"/></p>
          </div>
          <div class="valores">
            <h3>VALORES</h3>
            <p><xsl:value-of select="empresa/valores"/></p>
          </div>
        </div>
        
        <!-- informacion de contacto -->
        <div class="informacion-contacto">
          <h3>INFORMACION CONTACTO</h3>
          <div class="fotos-contacto">
            <div class="empresa-img">
              <img src="img/empresa.png" alt="icono empresa" class="icono-empresa"/>
              <p><xsl:value-of select="empresa/contacto/nombre_legal"/></p>
            </div>
            <div class="direccion-img">
              <img src="img/direccion.png" alt="icono empresa" class="icono-direccion"/>
              <p><xsl:value-of select="empresa/contacto/direccion"/></p>
            </div>
            <div class="telefono-img">
              <img src="img/telefono.png" alt="icono empresa" class="icono-telefono"/>
              <p><xsl:value-of select="empresa/contacto/telefono"/></p>
            </div>
            <div class="email-img">
              <img src="img/email.png" alt="icono empresa" class="icono-email"/>
              <p><xsl:value-of select="empresa/contacto/email"/></p>
            </div>
          </div>
          
          
          
        </div>
        
        
        
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
