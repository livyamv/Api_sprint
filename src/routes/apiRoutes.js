const router = require("express").Router();

const userController = require("../controller/userController");
const classroomController = require("../controller/classroomController");
const scheduleController = require("../controller/scheduleController");
const verifyJWT = require('../services/verifyJWT');

//User
router.post("/user/", userController.createUser);
router.post("/user/login", userController.loginUser);
router.get("/user/", verifyJWT, userController.getAllUsers);
router.put("/user/", verifyJWT, userController.updateUser);
router.delete("/user/:id", verifyJWT,userController.deleteUser);

//Classroom
router.post("/classroom/", verifyJWT,classroomController.createClassroom);
router.get("/classroom/", classroomController.getAllClassrooms);
router.get("/classroom/:number", verifyJWT,classroomController.getClassroomById);
router.put("/classroom/", verifyJWT,classroomController.updateClassroom);
router.delete("/classroom/:number", verifyJWT,classroomController.deleteClassroom);

//Schedule
router.post("/schedule/", scheduleController.createSchedule);
router.get("/schedule/", verifyJWT,scheduleController.getAllSchedules);
router.get("/disponibilidade/:fk_number/:date", scheduleController.getHorariosDisponiveisPorSalaEData);
router.put("/schedule/", verifyJWT,scheduleController.updateSchedule);
router.delete("/schedule/:id", verifyJWT,scheduleController.deleteSchedule);

module.exports = router;
