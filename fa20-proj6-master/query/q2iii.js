// Task 2iii

db.movies_metadata.aggregate([
    // TODO: Write your query here
    {
    	$project: {
    		_id: 1,
    		budget: {$cond: [{$and: [{$ne: ["$budget", null]},
    								{$ne: ["$budget", false]},
    								{$ne: ["$budget", ""]},
    								{$ne: ["$budget", undefined]}]},
    				 {$round: [{$cond: [{$isNumber: "$budget"}, "$budget", {$toInt: {$trim: {input: "$budget", chars: " USD$"}}}]}, -7]}
    				 , "unknown"]}
    	} 
    },

    {
    	$group: {
    		_id: "$budget",
    		//budget: "$budget",
    		count: {$sum: 1}
    	}
    },

    {
    	$sort: {
    		_id: 1
    	}
    },

    {
    	$project: {
    		_id: 0,
    		budget: "$_id",
    		count: 1
    	}
    }


]);