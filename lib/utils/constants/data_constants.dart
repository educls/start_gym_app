import "package:start_gym_app/utils/constants/path_contants.dart";
import "package:start_gym_app/utils/constants/text_constants.dart";
import 'package:start_gym_app/data/exercise_data.dart';
import 'package:start_gym_app/data/workout_data.dart';

class DataConstants {
// Workouts
  static final List<WorkoutData> workouts = [
    WorkoutData(
        title: TextConstants.yogaTitle,
        exercices: TextConstants.yogaExercises,
        minutes: TextConstants.yogaMinutes,
        currentProgress: 10,
        progress: 16,
        image: PathConstants.yoga,
        exerciseDataList: [
          ExerciseData(
            title: TextConstants.reclining,
            minutes: TextConstants.recliningMinutes,
            progress: 1,
            video: PathConstants.recliningVideo,
            description: TextConstants.warriorDescription,
            steps: [
              TextConstants.warriorStep1,
              TextConstants.warriorStep2,
              TextConstants.warriorStep1,
              TextConstants.warriorStep2,
              TextConstants.warriorStep1,
              TextConstants.warriorStep2,
            ],
          ),
          ExerciseData(
            title: TextConstants.cowPose,
            minutes: TextConstants.cowPoseMinutes,
            progress: 0.3,
            video: PathConstants.cowPoseVideo,
            description: TextConstants.warriorDescription,
            steps: [TextConstants.warriorStep1, TextConstants.warriorStep2],
          ),
          ExerciseData(
            title: TextConstants.warriorPose,
            minutes: TextConstants.warriorPoseMinutes,
            progress: 0.99,
            video: PathConstants.warriorIIVideo,
            description: TextConstants.warriorDescription,
            steps: [TextConstants.warriorStep1, TextConstants.warriorStep2],
          ),
        ]),
    WorkoutData(
        title: TextConstants.pilatesTitle,
        exercices: TextConstants.pilatesExercises,
        minutes: TextConstants.pilatesMinutes,
        currentProgress: 1,
        progress: 20,
        image: PathConstants.pilates,
        exerciseDataList: [
          ExerciseData(
            title: TextConstants.reclining,
            minutes: TextConstants.recliningMinutes,
            progress: 0.1,
            video: PathConstants.recliningVideo,
            description: TextConstants.warriorDescription,
            steps: [TextConstants.warriorStep1, TextConstants.warriorStep2],
          ),
          ExerciseData(
            title: TextConstants.cowPose,
            minutes: TextConstants.cowPoseMinutes,
            progress: 0.1,
            video: PathConstants.cowPoseVideo,
            description: TextConstants.warriorDescription,
            steps: [TextConstants.warriorStep1, TextConstants.warriorStep2],
          ),
          ExerciseData(
            title: TextConstants.warriorPose,
            minutes: TextConstants.warriorPoseMinutes,
            progress: 0.0,
            video: PathConstants.warriorIIVideo,
            description: TextConstants.warriorDescription,
            steps: [TextConstants.warriorStep1, TextConstants.warriorStep2],
          ),
        ]),
    WorkoutData(
        title: TextConstants.fullBodyTitle,
        exercices: TextConstants.fullBodyExercises,
        minutes: TextConstants.fullBodyMinutes,
        currentProgress: 12,
        progress: 14,
        image: PathConstants.fullBody,
        exerciseDataList: [
          ExerciseData(
            title: TextConstants.reclining,
            minutes: TextConstants.recliningMinutes,
            progress: 0.99,
            video: PathConstants.recliningVideo,
            description: TextConstants.warriorDescription,
            steps: [TextConstants.warriorStep1, TextConstants.warriorStep2],
          ),
          ExerciseData(
            title: TextConstants.cowPose,
            minutes: TextConstants.cowPoseMinutes,
            progress: 0.6,
            video: PathConstants.cowPoseVideo,
            description: TextConstants.warriorDescription,
            steps: [TextConstants.warriorStep1, TextConstants.warriorStep2],
          ),
          ExerciseData(
            title: TextConstants.warriorPose,
            minutes: TextConstants.warriorPoseMinutes,
            progress: 0.8,
            video: PathConstants.warriorIIVideo,
            description: TextConstants.warriorDescription,
            steps: [TextConstants.warriorStep1, TextConstants.warriorStep2],
          ),
        ]),
    WorkoutData(
      title: TextConstants.stretchingTitle,
      exercices: TextConstants.stretchingExercises,
      minutes: TextConstants.stretchingMinutes,
      currentProgress: 0,
      progress: 8,
      image: PathConstants.stretching,
      exerciseDataList: [
        ExerciseData(
          title: TextConstants.reclining,
          minutes: TextConstants.recliningMinutes,
          progress: 0.0,
          video: PathConstants.recliningVideo,
          description: TextConstants.warriorDescription,
          steps: [TextConstants.warriorStep1, TextConstants.warriorStep2],
        ),
        ExerciseData(
          title: TextConstants.cowPose,
          minutes: TextConstants.cowPoseMinutes,
          progress: 0.0,
          video: PathConstants.cowPoseVideo,
          description: TextConstants.warriorDescription,
          steps: [TextConstants.warriorStep1, TextConstants.warriorStep2],
        ),
        ExerciseData(
          title: TextConstants.warriorPose,
          minutes: TextConstants.warriorPoseMinutes,
          progress: 0.0,
          video: PathConstants.warriorIIVideo,
          description: TextConstants.warriorDescription,
          steps: [TextConstants.warriorStep1, TextConstants.warriorStep2],
        ),
      ],
    ),
  ];

  static final List<WorkoutData> homeWorkouts = [
    WorkoutData(
        title: TextConstants.cardioTitle,
        exercices: TextConstants.cardioExercises,
        minutes: TextConstants.cardioMinutes,
        currentProgress: 10,
        progress: 16,
        image: PathConstants.cardio,
        exerciseDataList: [
          ExerciseData(
            title: TextConstants.reclining,
            minutes: TextConstants.recliningMinutes,
            progress: 1,
            video: PathConstants.recliningVideo,
            description: TextConstants.warriorDescription,
            steps: [
              TextConstants.warriorStep1,
              TextConstants.warriorStep2,
              TextConstants.warriorStep1,
              TextConstants.warriorStep2,
              TextConstants.warriorStep1,
              TextConstants.warriorStep2,
            ],
          ),
          ExerciseData(
            title: TextConstants.cowPose,
            minutes: TextConstants.cowPoseMinutes,
            progress: 0.3,
            video: PathConstants.cowPoseVideo,
            description: TextConstants.warriorDescription,
            steps: [TextConstants.warriorStep1, TextConstants.warriorStep2],
          ),
          ExerciseData(
            title: TextConstants.warriorPose,
            minutes: TextConstants.warriorPoseMinutes,
            progress: 0.99,
            video: PathConstants.warriorIIVideo,
            description: TextConstants.warriorDescription,
            steps: [TextConstants.warriorStep1, TextConstants.warriorStep2],
          ),
        ]),
    WorkoutData(
        title: TextConstants.armsTitle,
        exercices: TextConstants.armsExercises,
        minutes: TextConstants.armsMinutes,
        currentProgress: 1,
        progress: 20,
        image: PathConstants.cardio,
        exerciseDataList: [
          ExerciseData(
            title: TextConstants.reclining,
            minutes: TextConstants.recliningMinutes,
            progress: 0.1,
            video: PathConstants.recliningVideo,
            description: TextConstants.warriorDescription,
            steps: [TextConstants.warriorStep1, TextConstants.warriorStep2],
          ),
          ExerciseData(
            title: TextConstants.cowPose,
            minutes: TextConstants.cowPoseMinutes,
            progress: 0.1,
            video: PathConstants.cowPoseVideo,
            description: TextConstants.warriorDescription,
            steps: [TextConstants.warriorStep1, TextConstants.warriorStep2],
          ),
          ExerciseData(
            title: TextConstants.warriorPose,
            minutes: TextConstants.warriorPoseMinutes,
            progress: 0.0,
            video: PathConstants.warriorIIVideo,
            description: TextConstants.warriorDescription,
            steps: [TextConstants.warriorStep1, TextConstants.warriorStep2],
          ),
        ]),
  ];
}
