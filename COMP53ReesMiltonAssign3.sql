-- Karen Rees-Milton. April 16 2018
-- Chapter 6
-- Question#3
SELECT vendor_name, 
	COUNT(invoice_id) AS numberOfInvoices,
		SUM(invoice_total) AS totalOfInvoices
FROM vendors JOIN invoices USING(vendor_id)
GROUP BY vendor_name
ORDER BY numberOfInvoices DESC;

-- Question#5
SELECT account_description,
	COUNT(*) AS itemCount,
		SUM(line_item_amount) AS totalAmounts
FROM general_ledger_accounts gla
	JOIN invoice_line_items ili
		ON gla.account_number = ili.account_number
			JOIN invoices i
				ON ili.invoice_id = i.invoice_id
WHERE invoice_date BETWEEN '2014-04-01' AND '2014-06-30'
GROUP BY account_description
HAVING itemCount > 1
ORDER BY totalAmounts DESC;

-- Question#6
SELECT account_number,
	SUM(line_item_amount) AS amountTotal
FROM general_ledger_accounts JOIN invoice_line_items USING(account_number)
GROUP BY account_number WITH ROLLUP;

-- Chapter 7
-- Question#1
 SELECT DISTINCT vendor_name
 FROM vendors 
 WHERE vendor_id IN
 (SELECT DISTINCT vendor_id
	FROM invoices)
 ORDER BY vendor_name;
 
 -- Question#2
 SELECT invoice_number, invoice_total
 FROM invoices
 WHERE payment_total >
 (SELECT AVG(payment_total)
 FROM invoices
 WHERE payment_total > 0)
 ORDER BY invoice_total DESC;

-- Question#4
SELECT vendor_name, invoice_id, invoice_sequence, line_item_amount
FROM vendors JOIN invoices USING(vendor_id)
	JOIN invoice_line_items USING(invoice_id)
WHERE invoice_id IN
(SELECT invoice_id
FROM invoice_line_items
WHERE invoice_sequence > 1);

-- Chapter 5
-- Question#1
INSERT INTO terms 
	(terms_id, terms_description, terms_due_days)
VALUES
	(6, 'Net due 120 days', 120);

-- Question#2
UPDATE terms
SET terms_description = 'Net due 125 days',
	terms_due_days = 125
WHERE terms_id = 6;

-- Question#3
DELETE FROM terms
WHERE terms_id = 6;

-- Question#4
INSERT INTO invoices VALUES
	(DEFAULT, 32, 'AX-014-027', '2014-08-01', 434.58, 0, 0, 2, '2014-08-31', NULL);

-- Question#6
UPDATE invoices
SET credit_total = 0.1 * invoice_total,
	payment_total = invoice_total - credit_total
WHERE invoice_id = 115;

-- Question#8
UPDATE invoices
SET terms_id = 2
WHERE EXISTS
	(SELECT *
	FROM vendors
	WHERE default_terms_id = 2);

-- Question#9
DELETE FROM invoice_line_items
WHERE invoice_id = 115;

DELETE FROM invoices
WHERE invoice_id = 115;

























