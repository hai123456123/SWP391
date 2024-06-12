/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Dal;

import Model.User;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author ADMIN
 */
public class AccountDao extends DBContext {

    public User listCustomer(String email) {

        String sql = "select * from [dbo].[Users]";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, email);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                User a = new User();
                a.setId(rs.getInt("id"));
                a.setEmail(rs.getString("email"));
                a.setPass(rs.getString("pass"));
                a.setFullName(rs.getString("fullName"));
                a.setPhone(rs.getInt("phone"));
                a.setAddress(rs.getString("address"));
                a.setRoleId(rs.getInt("roleId"));
                return a;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public User GetAccount(String gmail, String pass) {

        String sql = "select * from [dbo].[Users] where email=? and pass=?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, gmail);
            st.setString(2, pass);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                User a = new User();
                a.setId(rs.getInt("id"));
                a.setEmail(rs.getString("email"));
                a.setPass(rs.getString("pass"));
                a.setFullName(rs.getString("fullName"));
                a.setPhone(rs.getInt("phone"));
                a.setAddress(rs.getString("address"));
                a.setRoleId(rs.getInt("roleId"));
                return a;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public List<User> getAllAccount() {
        List<User> list = new ArrayList<>();
        String sql = "select * from Users";  // Corrected table name
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                User a = new User();
                a.setId(rs.getInt("id"));
                a.setEmail(rs.getString("email"));
                a.setPass(rs.getString("pass"));
                a.setFullName(rs.getString("fullName"));
                a.setPhone(rs.getInt("phone"));
                a.setAddress(rs.getString("address"));
                a.setRoleId(rs.getInt("roleId"));
                list.add(a);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public User GetAccountById(int id) {

        String sql = "select * from [dbo].[Users] where id=?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                User a = new User();
                a.setId(rs.getInt("id"));
                a.setEmail(rs.getString("email"));
                a.setPass(rs.getString("pass"));
                a.setFullName(rs.getString("fullName"));
                a.setPhone(rs.getInt("phone"));
                a.setAddress(rs.getString("address"));
                a.setRoleId(rs.getInt("roleId"));
                return a;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public User CheckAccountByEmail(String email) {

        String sql = "select * from [dbo].[Users] where email = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, email);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                User a = new User();
                a.setId(rs.getInt("id"));
                a.setEmail(rs.getString("email"));
                a.setPass(rs.getString("pass"));
                a.setFullName(rs.getString("fullName"));
                a.setPhone(rs.getInt("phone"));
                a.setAddress(rs.getString("address"));
                a.setRoleId(rs.getInt("roleId"));
                return a;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public void UpdatePassword(String email, String pass) {
        String sql = "UPDATE [dbo].[Users]\n"
                + "   SET [pass] = ?\n"
                + " WHERE email = ?";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, pass);
            st.setString(2, email);
            st.executeUpdate();

        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public void ChangePasswordById(int id, String pass) {
        String sql = "UPDATE [dbo].[Users]\n"
                + "   SET [pass] = ?\n"
                + " WHERE id = ?";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, pass);
            st.setInt(2, id);
            st.executeUpdate();

        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public void UpdateAccountById(int id) {
        String sql = "UPDATE [dbo].[Users]\n"
                + "   SET [email] = ?\n"
                + "      ,[fullName] = ?\n"
                + "      ,[phone] = ?\n"
                + "      ,[address] = ?\n"
                + "      ,[roleId] = ?\n"
                + " WHERE id =?";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            st.executeUpdate();

        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public void UpdateAccountById(int id, String email, String fullName, String phone, String address) {
        String sql = "UPDATE [dbo].[Users]\n"
                + "   SET [email] = ?,\n"
                + "      [fullName] = ?,\n"
                + "      [phone] = ?,\n"
                + "      [address] = ?\n" // Loại bỏ dấu phẩy ở đây
                + " WHERE id = ?";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, email);
            st.setString(2, fullName);
            st.setString(3, phone);
            st.setString(4, address);
            st.setInt(5, id);
            st.executeUpdate();

        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public void UpdateProfileById(int id, String fullName, String phone, String address) {
        String sql = "UPDATE [dbo].[Users]\n"
                + "    SET  [fullName] = ?,\n"
                + "      [phone] = ?,\n"
                + "      [address] = ?\n" // Loại bỏ dấu phẩy ở đây
                + " WHERE id = ?";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, fullName);
            st.setString(2, phone);
            st.setString(3, address);
            st.setInt(4, id);
            st.executeUpdate();

        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public void deleteUserWithOrders(int uid) {
        String deletePaymentsSQL = "DELETE FROM [dbo].[Payment] WHERE oid IN (SELECT id FROM [dbo].[Order] WHERE userId = ?)";
        String deleteOrderDetailsSQL = "DELETE FROM [dbo].[OrderDetail] WHERE oid IN (SELECT id FROM [dbo].[Order] WHERE userId = ?)";
        String deleteOrdersSQL = "DELETE FROM [dbo].[Order] WHERE userId = ?";
        String deleteUserSQL = "DELETE FROM [dbo].[Users] WHERE id = ?";
        try {
            // Start transaction
            connection.setAutoCommit(false);

            // Delete payments
            PreparedStatement stPayments = connection.prepareStatement(deletePaymentsSQL);
            stPayments.setInt(1, uid);
            stPayments.executeUpdate();

            // Delete order details
            PreparedStatement stOrderDetails = connection.prepareStatement(deleteOrderDetailsSQL);
            stOrderDetails.setInt(1, uid);
            stOrderDetails.executeUpdate();

            // Delete orders
            PreparedStatement stOrders = connection.prepareStatement(deleteOrdersSQL);
            stOrders.setInt(1, uid);
            stOrders.executeUpdate();

            // Delete user
            PreparedStatement stUser = connection.prepareStatement(deleteUserSQL);
            stUser.setInt(1, uid);
            stUser.executeUpdate();

            // Commit transaction
            connection.commit();

        } catch (SQLException e) {
            System.out.println(e);
            try {
                // Rollback transaction if something goes wrong
                connection.rollback();
            } catch (SQLException rollbackEx) {
                System.out.println(rollbackEx);
            }
        } finally {
            try {
                // Set auto-commit back to true
                connection.setAutoCommit(true);
            } catch (SQLException ex) {
                System.out.println(ex);
            }
        }
    }

    public static void main(String[] args) {
        String email = "hai31082003@gmail.com";
        String pass = "123";
        AccountDao ad = new AccountDao();
        User u = ad.CheckAccountByEmail(email);
        System.out.println(u.getFullName());
    }
}
