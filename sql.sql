--1 
SELECT 
    COUNT(*) AS total_paquetes,
    SUM(CASE WHEN ESTADO = 'ENTREGADO' THEN 1 ELSE 0 END) AS entregados,
    ROUND(
        (SUM(CASE WHEN ESTADO = 'ENTREGADO' THEN 1 ELSE 0 END) / COUNT(*)) * 100,
        2
    ) AS TEE_porcentaje
FROM packages
WHERE YEAR(created_at) = 2024;