--1 

SELECT 
    COUNT(*) AS total_paquetes,
    SUM(CASE WHEN ESTADO = 'ENTREGADO' THEN 1 ELSE 0 END) AS entregados,
    ROUND(
        (SUM(CASE WHEN ESTADO = 'ENTREGADO' THEN 1 ELSE 0 END) / COUNT(*)) * 100,
        2
    ) AS TEE_porcentaje
FROM packages
WHERE YEAR(created_at) = 2024
  AND MONTH(created_at) = 5;


--2
/*
KPI-E2: TASA DE REZAGO (TR)
  Fórmula    : (Paquetes en rezago / Total admitidos) × 100
  Fuente     : packages.ESTADO = 'REZAGO' o daterezago IS NOT NULL
  Meta       : ≤ 5%
  Frecuencia : Mensual
  Alerta     : > 10% = Nivel Crítico
  Descripción: Mide el porcentaje de paquetes que superan el plazo máximo
               permitido sin ser entregados o devueltos.
*/

