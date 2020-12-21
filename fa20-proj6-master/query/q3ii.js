// Task 3ii

db.credits.aggregate([
    // TODO: Write your query here
    {$unwind: "$crew"},

    {$project: {
    	_id: "$movieId",
    	crew: "$crew.id",
    	job: "$crew.job"
    }},

    {$match: {
    	crew: 5655,
    	job: "Director"
    }},

    {
    	$lookup: {
    		from: "credits",
    		localField: "_id",
    		foreignField: "movieId",
    		as: "movies"
    	}
    },

    {$unwind: "$movies"},
    {$unwind: "$movies.cast"},

    {$project: {
    	_id: 1,
    	name: "$movies.cast.name",
    	id: "$movies.cast.id"
    }},

    {$group: {
    	_id: {val1: "$name", val2: "$id"},
    	count: {$sum: 1}
    }},

    {$project: {
    	_id: 0,
    	count: 1,
    	id: "$_id.val2",
    	name: "$_id.val1"
    }},

    {
    	$sort: {
    		count: -1,
    		id: 1
    	}
    },

    {$limit: 5}


]);