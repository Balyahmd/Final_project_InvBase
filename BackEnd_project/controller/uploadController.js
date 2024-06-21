const { User } = require("../models");

class UploadController {
  static async uploadImage(req, res) {
    if (!req.file) {
      return res.status(400).json({ message: "No file uploaded" });
    }

    const { filename } = req.file;
    const userId = req.user.id;

    if (!userId) {
      return res.status(400).json({ message: "User ID is required" });
    }

    try {
      const user = await User.findByPk(userId);
      if (!user) {
        return res.status(404).json({ message: "user not found" });
      }
      user.image = filename;
      await user.save();

      res.status(200).json({
        message: `Image uploaded successfully for user ${user.username}`,
        user,
      });
    } catch (error) {
      res
        .status(500)
        .json({ message: "Failed to update user image", error: error.message });
    }
  }
}

module.exports = UploadController;
