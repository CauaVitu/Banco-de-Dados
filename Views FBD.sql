-- View que retorna a soma de todos os valores do tipo entrada
-- Depois todos os valores do tipo saida
-- E por ultimo a diferença entre esses dois valores
CREATE OR REPLACE VIEW Resumo_Financeiro AS
SELECT
    u.ID_Usuario,
    u.Nome_Usuario,
    COALESCE(SUM(CASE WHEN c.Tipo_Categoria = 'Entrada' THEN t.Valor ELSE 0 END), 0) AS Total_Entradas,
    COALESCE(SUM(CASE WHEN c.Tipo_Categoria = 'Saida' THEN t.Valor ELSE 0 END), 0) AS Total_Saidas,
    COALESCE(SUM(CASE WHEN c.Tipo_Categoria = 'Entrada' THEN t.Valor ELSE 0 END), 0) -
    COALESCE(SUM(CASE WHEN c.Tipo_Categoria = 'Saida' THEN t.Valor ELSE 0 END), 0) AS Saldo
FROM Usuario u
LEFT JOIN Transacao t ON u.ID_Usuario = t.ID_Usuario
LEFT JOIN CategoriaTransacao c ON t.ID_Categoria = c.ID_Categoria
GROUP BY u.ID_Usuario, u.Nome_Usuario;

-- View que retorna os produtos mais vendidos dos usuários
-- Where com o id do usuario retorna só os dele
CREATE OR REPLACE VIEW Produtos_Mais_Vendidos AS
SELECT
    u.ID_Usuario,
    u.Nome_Usuario,
    p.ID_Produto,
    p.Nome_Produto,
    SUM(vp.Quantidade) AS Total_Vendido
FROM Produto p
JOIN Venda_Produto vp ON p.ID_Produto = vp.ID_Produto
JOIN Usuario u ON p.ID_Usuario = u.ID_Usuario
GROUP BY u.ID_Usuario, u.Nome_Usuario, p.ID_Produto, p.Nome_Produto;

-- View que retorna o lucro dos produtos dos usuarios
CREATE OR REPLACE VIEW Lucro_Produtos AS
SELECT
	u.Nome_Usuario,
	u.ID_Usuario,
    p.ID_Produto,
    p.Nome_Produto,
    SUM(vp.Quantidade * (vp.Preco_Unitario_Venda - p.Preco_Custo)) AS Lucro_Total
FROM Produto p
JOIN Venda_Produto vp ON p.ID_Produto = vp.ID_Produto
JOIN Usuario u on U.ID_Usuario = p.ID_Usuario
GROUP BY p.ID_Produto, p.Nome_Produto,u.ID_Usuario;

select * from Resumo_Financeiro r
ORDER BY r.ID_Usuario

SELECT * FROM Produtos_Mais_Vendidos pmv
ORDER BY total_vendido desc

SELECT * FROM Lucro_Produtos
where id_usuario = '1';
