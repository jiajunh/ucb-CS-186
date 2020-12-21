// Task 1iv

db.ratings.aggregate([
    // TODO: Write your query here
    {
    	$match: {
    		userId: 186
    	}
    },

    {
    	$sort: {"timestamp": -1}
    },

    {$limit:5},

    {
    	$lookup: {
             from: "movies_metadata",
             localField: "_id",
             foreignField: "movieId",
             as: "movies"
         }
    },

    {
    	$group: {
    		_id: null,
    		movieIds: {$push: "$movieId"},
    		ratings: {$push: "$rating"},
    		timestamps: {$push: "$timestamp"}
    	}
    },

    {
    	$project: {
    		_id: 0,
    		movieIds: 1,
    		ratings: 1,
    		timestamps: 1
    	}
    }
]);