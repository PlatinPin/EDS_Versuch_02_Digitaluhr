# EDS_Versuch_02_Digitaluhr
Meine Löschung zum zweiten Laborversuch im Modul "Entwurf Digitaler Systeme".  
In diesem Versuch soll eine Digitaluhr auf einem FPGA implementiert werden.  
Diese Digitaluhr wird mit einem 100-MHz-Takt gespeist und soll außerdem die Möglichkeit bieten, gestellt zu werden und möglichst generativ gestaltet sein.   
<br>
<ins>Zähler-Modul:</ins>   
Das Zähler-Modul zählt zyklisch bis zu einer einstellbaren Maximalzahl (1 bis 9). Bei Aktivierung des Takts erhöht sich der Zähler um eins. Erreicht er die Maximalzahl, wird er im nächsten Takt zurückgesetzt und ein Überlaufsignal für einen Takt gesetzt. Dieses Signal dient als Takt für die nächste Stufe.
<br>
