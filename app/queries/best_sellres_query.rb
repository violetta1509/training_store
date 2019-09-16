class BestSellresQuery
  def best_sellers
    Book.find_by_sql("SELECT * FROM books WHERE id IN (
                        SELECT book_id FROM (SELECT DISTINCT ON(category_id) category_id ,total, book_id FROM (
                          SELECT order_items.book_id, SUM(order_items.quantity) AS total, books.category_id
                            FROM order_items
                            LEFT JOIN books ON order_items.book_id = books.id
                            LEFT JOIN orders ON orders.id = order_items.order_id
                            WHERE orders.status = 'delivered'
                            GROUP BY order_items.book_id, books.category_id)
                            AS sub_query ORDER BY category_id , total DESC LIMIT 4) AS book_ids);")
  end
end
