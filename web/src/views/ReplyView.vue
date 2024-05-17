<template>
	<!-- comment  -->
	<div v-for="(comment, index) in comments " :key="index" :class="{ 'mg-3': comment.parent_id != null }">
		<div class="reply">
			<div class="reply-header clearfix">
				<div class="reply-profile">
					<img :src="url + comment?.user?.profile" alt="" width="20px" height="20px">
				</div>
				<div class="left-detail">
					<h3>
						{{ comment.user?.name  }}
					</h3>
					<p>
						{{ comment?.created_at }}
					</p>
				</div>
			</div>

			<p class="reply-text" @dblclick="comment.edit = 1">
				{{ comment?.comment }} 
			</p>

			<!-- comment update  -->
			<form class="" v-if="comment.edit == 1 && comment.parent_id == null"
				@submit.prevent="updateComment(comment.id, postId, comment.comment), comment.edit = 0">
				<input type="text" id="edit-comtext" class="reply{{ $comment->id }}" v-model="comment.comment"
					name="comment">
				<input type="hidden" name="post_id" v-model="updateForm.post_id" />
			</form>


			<form class="" v-if="comment.edit == 1 && comment.parent_id != null"
				@submit.prevent="updateReply(comment.id, postId, comment.parent_id, comment.comment)">
				<input type="text" id="edit-comtext" class="reply{{ $comment->id }}" v-model="comment.comment"
					name="comment">
			</form>

			<div class="comment-btn-group">
				<button @click="deleteComment(comment.id)" class="delete-comment" v-if="userId==comment.user?.id" >delete
				</button>
				<p><button @click="comment.reply = !comment.reply" class="comment-reply">reply</button></p>
			</div>
		</div>

		<!-- reply  -->
		<div class="reply-form" v-if="comment.reply == 1">
			<form @submit.prevent="storeReply(comment.id, postId, userId), comment.reply = 0">
				<div class="form-group">
					<textarea type="text" v-model="replyForm.comment" name="comment" class="reply-box" required
						placeholder="Reply in here"></textarea>
				</div>
				<div class="reply-button-group">
					<div class="d"></div>
					<input type="submit" class="reply-btn" style="font-size: 0.8em;" value="Reply" />
				</div>
			</form>
		</div>

		<!-- recurscive component  -->
		<ReplyView v-if="comment.replies" :comments="comment.replies"
			@listComment="(commentList) => $emit('listComment', commentList)" :postId="postId" :userId="userId"></ReplyView>

	</div>
</template>

<script setup >
import { ref, reactive, onMounted } from 'vue'
import { useRouter } from 'vue-router';
import axios from 'axios'

const url = ref('http://127.0.0.1:8000/storage/');
const router = useRouter();
const updateForm = reactive({
	comment: '',
	post_id: '',
	comment_id: '',
});
const updateReplyForm = reactive({
	comment: '',
	post_id: '',
	parent_id: '',
	comment_id: '',
});
const replyForm = reactive({
	comment: '',
	post_id: '',
	user_id: '',
	comment_id: '',
});

const props = defineProps({
	comments: Array,
	postId: Number,
	userId: Number,
});


const emit = defineEmits('listComment');

//update comment
const updateComment = async (id, postId, comment) => {
	updateForm.comment_id = id;
	updateForm.comment = comment;
	updateForm.post_id = postId;

	await axios.post('http://127.0.0.1:8000/api/updateComment', updateForm).then((response) => {
		emit('listComment')
	})

}

//update reply
const updateReply = async (id, postId, patent_id, comment) => {
	console.log(postId);
	updateReplyForm.comment_id = id
	updateReplyForm.comment = comment
	updateReplyForm.post_id = postId,
		updateReplyForm.parent_id = patent_id

	await axios.post('http://127.0.0.1:8000/api/updateComment', updateReplyForm).then((response) => {
		emit('listComment');
	})
}

// store reply 
const storeReply = async (id, postId, userId) => {
	replyForm.comment_id = id;
	replyForm.post_id = postId;
	replyForm.user_id = userId;
	await axios.post('http://127.0.0.1:8000/api/reply', replyForm).then((response) => {
		emit('listComment')
	});
}

// delete reply 
const deleteComment = async (id) => {
	await axios.delete(`http://127.0.0.1:8000/api/comment/${id}`)
		.then((response) => {
			emit('listComment')
			router.push({ name: 'detail', query: { deleteCommentId: id } })
		})
}

</script>

<style scoped>
.reply-button-group {
	width: 100%;
	display: flex;
	align-items: center;
	justify-content: space-between;
	margin-bottom: 10px;
}
</style>