--1 
/*

KPI-E1: TASA DE ENTREGA EXITOSA (TEE)
  Fórmula    : (Paquetes entregados / Total paquetes admitidos) × 100
  Fuente     : packages.ESTADO = 'ENTREGADO' / COUNT(packages)
  Meta       : ≥ 92%
  Frecuencia : Mensual / Trimestral
  Alerta     : < 85% = Nivel Crítico
  Descripción: Mide la eficacia global del sistema postal. Es el KPI más
               representativo de la calidad del servicio.
*/

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

SELECT 
    COUNT(*) AS total_paquetes,
    SUM(CASE 
            WHEN ESTADO = 'REZAGO' 
            THEN 1 ELSE 0 
        END) AS paquetes_rezago,
    ROUND(
        (SUM(CASE 
                WHEN ESTADO = 'REZAGO'  
                THEN 1 ELSE 0 
            END) / COUNT(*)) * 100
    ,2) AS TR_porcentaje
FROM packages
WHERE YEAR(created_at) = 2024
  AND MONTH(created_at) = 5;



-- KPI-E3: INGRESOS TOTALES POR PERÍODO 
/*

  Fórmula    : SUM(nationals.IMPORTE) + SUM(internationals.PRECIO) por mes
  Fuente     : Tablas nationals e internationals (campos IMPORTE y PRECIO)
  Meta       : Definida por la gerencia financiera (baseline)
  Frecuencia : Mensual / Anual
  Descripción: Ingreso bruto generado por los servicios postales nacionales
               e internacionales. Permite proyecciones y presupuesto.
*/


