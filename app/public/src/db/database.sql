-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 30-Jan-2025 às 01:39
-- Versão do servidor: 10.4.27-MariaDB
-- versão do PHP: 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `database`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `cliente`
--

CREATE TABLE `cliente` (
  `id_cliente` int(11) NOT NULL,
  `nome_cliente` varchar(60) NOT NULL,
  `codigo` int(11) NOT NULL,
  `natureza` enum('PF','PJ') NOT NULL,
  `cnpj_cpf` varchar(30) NOT NULL,
  `rg` int(11) NOT NULL,
  `nascimento` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `id_municipio` int(11) NOT NULL,
  `ie` int(11) NOT NULL,
  `bairro` varchar(60) NOT NULL,
  `numero` int(11) NOT NULL,
  `logradouro` varchar(120) NOT NULL,
  `email` varchar(120) NOT NULL,
  `pacote_promocao` int(11) NOT NULL,
  `status` char(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Extraindo dados da tabela `cliente`
--

INSERT INTO `cliente` (`id_cliente`, `nome_cliente`, `codigo`, `natureza`, `cnpj_cpf`, `rg`, `nascimento`, `id_municipio`, `ie`, `bairro`, `numero`, `logradouro`, `email`, `pacote_promocao`, `status`) VALUES
(7, 'Nairo', 0, 'PF', '604.846.668-43', 362933881, '2025-01-29 00:13:58', 1, 0, 'Centro', 52, 'Rua Random', 'nairo@senacrs.com', 0, '1');

-- --------------------------------------------------------

--
-- Estrutura da tabela `forma_pagamento`
--

CREATE TABLE `forma_pagamento` (
  `id_forma_pagamento` int(11) NOT NULL,
  `desc_forma_pagamento` varchar(30) NOT NULL,
  `id_tipo_recebimento` int(11) NOT NULL,
  `permite_parcelamento` char(1) NOT NULL,
  `qtd_max_parcelas` int(11) NOT NULL,
  `status` char(1) NOT NULL,
  `codigo` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Extraindo dados da tabela `forma_pagamento`
--

INSERT INTO `forma_pagamento` (`id_forma_pagamento`, `desc_forma_pagamento`, `id_tipo_recebimento`, `permite_parcelamento`, `qtd_max_parcelas`, `status`, `codigo`) VALUES
(1, 'Pix', 0, 'N', 1, '', 0),
(2, 'Credito', 0, 'S', 12, '', 0),
(3, 'Debito', 0, 'N', 1, '', 0),
(4, 'Boleto', 0, 'N', 12, '', 0),
(5, 'Dinheiro', 0, 'N', 1, '', 0);

-- --------------------------------------------------------

--
-- Estrutura da tabela `item`
--

CREATE TABLE `item` (
  `id_item` int(11) NOT NULL,
  `desc_item` varchar(60) NOT NULL,
  `preco_item` double(11,2) NOT NULL,
  `quant_item` int(11) NOT NULL,
  `codigo` int(11) NOT NULL,
  `codigo_barra` varchar(30) NOT NULL,
  `id_categoria` int(11) NOT NULL,
  `registra_comissao` int(11) NOT NULL,
  `status` char(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Extraindo dados da tabela `item`
--

INSERT INTO `item` (`id_item`, `desc_item`, `preco_item`, `quant_item`, `codigo`, `codigo_barra`, `id_categoria`, `registra_comissao`, `status`) VALUES
(1, 'Elden Ring', 299.90, 10, 0, '', 0, 0, ''),
(2, 'Dark Souls III', 120.00, 10, 0, '', 0, 0, ''),
(3, 'Undertale', 19.90, 10, 0, '', 0, 0, ''),
(4, 'Deltarune', 29.90, 10, 0, '', 0, 0, ''),
(5, 'Omori', 16.90, 10, 0, '', 0, 0, '');

-- --------------------------------------------------------

--
-- Estrutura da tabela `item_venda`
--

CREATE TABLE `item_venda` (
  `id_item_venda` int(11) NOT NULL,
  `id_item` int(11) NOT NULL,
  `id_venda` int(11) NOT NULL,
  `quant` int(11) NOT NULL,
  `preco` double(11,2) NOT NULL,
  `total` double(11,2) NOT NULL,
  `desconto` int(11) NOT NULL,
  `acrescimo` int(11) NOT NULL,
  `data_venda` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `id_usuario` int(11) NOT NULL,
  `status` char(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `municipio`
--

CREATE TABLE `municipio` (
  `id_municipio` int(11) NOT NULL,
  `nome_municipio` varchar(120) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Extraindo dados da tabela `municipio`
--

INSERT INTO `municipio` (`id_municipio`, `nome_municipio`) VALUES
(1, 'Santa Cruz do Sul');

-- --------------------------------------------------------

--
-- Estrutura da tabela `recebimento_venda`
--

CREATE TABLE `recebimento_venda` (
  `id_recebimento` int(11) NOT NULL,
  `id_venda` int(11) NOT NULL,
  `id_forma_pagamento` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `sys_log_registro`
--

CREATE TABLE `sys_log_registro` (
  `id_sys_log` int(11) NOT NULL,
  `id_tipo_operacao` int(11) NOT NULL,
  `table_name` varchar(60) NOT NULL,
  `query` text NOT NULL,
  `id_usuario_registro` int(11) NOT NULL,
  `status` char(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `tipo_operacao`
--

CREATE TABLE `tipo_operacao` (
  `id_tipo_operacao` int(11) NOT NULL,
  `denominacao` varchar(30) NOT NULL,
  `status` char(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `tipo_recebimento`
--

CREATE TABLE `tipo_recebimento` (
  `id_tipo_recebimento` int(11) NOT NULL,
  `desc_tipo_recebimento` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `tipo_usuario`
--

CREATE TABLE `tipo_usuario` (
  `id_tipo_usuario` int(11) NOT NULL,
  `tipo_usuario` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Extraindo dados da tabela `tipo_usuario`
--

INSERT INTO `tipo_usuario` (`id_tipo_usuario`, `tipo_usuario`) VALUES
(1, 'Admin'),
(2, 'Comum');

-- --------------------------------------------------------

--
-- Estrutura da tabela `usuario`
--

CREATE TABLE `usuario` (
  `id_usuario` int(11) NOT NULL,
  `nome` varchar(30) NOT NULL,
  `email` varchar(60) NOT NULL,
  `id_tipo_usuario` int(11) NOT NULL,
  `status` char(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `venda`
--

CREATE TABLE `venda` (
  `id_venda` int(11) NOT NULL,
  `status_venda` char(1) NOT NULL,
  `data_venda` timestamp NOT NULL DEFAULT current_timestamp(),
  `total_venda` double(11,2) NOT NULL,
  `id_cliente` int(11) NOT NULL,
  `numero_venda` int(11) NOT NULL,
  `total_item` int(11) NOT NULL,
  `desconto` int(11) NOT NULL,
  `acrescimo` int(11) NOT NULL,
  `observacao` varchar(300) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Índices para tabelas despejadas
--

--
-- Índices para tabela `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`id_cliente`),
  ADD KEY `fk_municipio` (`id_municipio`);

--
-- Índices para tabela `forma_pagamento`
--
ALTER TABLE `forma_pagamento`
  ADD PRIMARY KEY (`id_forma_pagamento`);

--
-- Índices para tabela `item`
--
ALTER TABLE `item`
  ADD PRIMARY KEY (`id_item`);

--
-- Índices para tabela `item_venda`
--
ALTER TABLE `item_venda`
  ADD PRIMARY KEY (`id_item_venda`);

--
-- Índices para tabela `municipio`
--
ALTER TABLE `municipio`
  ADD PRIMARY KEY (`id_municipio`);

--
-- Índices para tabela `recebimento_venda`
--
ALTER TABLE `recebimento_venda`
  ADD PRIMARY KEY (`id_recebimento`);

--
-- Índices para tabela `sys_log_registro`
--
ALTER TABLE `sys_log_registro`
  ADD PRIMARY KEY (`id_sys_log`);

--
-- Índices para tabela `tipo_recebimento`
--
ALTER TABLE `tipo_recebimento`
  ADD PRIMARY KEY (`id_tipo_recebimento`);

--
-- Índices para tabela `tipo_usuario`
--
ALTER TABLE `tipo_usuario`
  ADD PRIMARY KEY (`id_tipo_usuario`);

--
-- Índices para tabela `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`id_usuario`),
  ADD KEY `fk_tipo_usuario` (`id_tipo_usuario`);

--
-- Índices para tabela `venda`
--
ALTER TABLE `venda`
  ADD PRIMARY KEY (`id_venda`);

--
-- AUTO_INCREMENT de tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `cliente`
--
ALTER TABLE `cliente`
  MODIFY `id_cliente` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de tabela `forma_pagamento`
--
ALTER TABLE `forma_pagamento`
  MODIFY `id_forma_pagamento` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de tabela `item`
--
ALTER TABLE `item`
  MODIFY `id_item` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de tabela `item_venda`
--
ALTER TABLE `item_venda`
  MODIFY `id_item_venda` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `municipio`
--
ALTER TABLE `municipio`
  MODIFY `id_municipio` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `recebimento_venda`
--
ALTER TABLE `recebimento_venda`
  MODIFY `id_recebimento` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `sys_log_registro`
--
ALTER TABLE `sys_log_registro`
  MODIFY `id_sys_log` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `tipo_recebimento`
--
ALTER TABLE `tipo_recebimento`
  MODIFY `id_tipo_recebimento` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `tipo_usuario`
--
ALTER TABLE `tipo_usuario`
  MODIFY `id_tipo_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de tabela `usuario`
--
ALTER TABLE `usuario`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de tabela `venda`
--
ALTER TABLE `venda`
  MODIFY `id_venda` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restrições para despejos de tabelas
--

--
-- Limitadores para a tabela `cliente`
--
ALTER TABLE `cliente`
  ADD CONSTRAINT `fk_municipio` FOREIGN KEY (`id_municipio`) REFERENCES `municipio` (`id_municipio`);

--
-- Limitadores para a tabela `usuario`
--
ALTER TABLE `usuario`
  ADD CONSTRAINT `fk_tipo_usuario` FOREIGN KEY (`id_tipo_usuario`) REFERENCES `tipo_usuario` (`id_tipo_usuario`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
